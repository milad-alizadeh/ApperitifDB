-- set the similarity threshold for pg_trgm
set
  pg_trgm.similarity_threshold = 0.1;

-- drop the function if it already exists
drop function if exists get_recipes_by_category_ids (text, uuid[], int, int) cascade;

-- drop the custom types if they already exist.
drop type if exists recipes_page_info cascade;

drop type if exists recipe_preview cascade;

-- define a custom type to represent a recipe preview.
create type recipe_preview as (id uuid, name text, image_url text);

-- define a custom type for the function's return value
create type recipes_page_info as (
  recipes recipe_preview[],
  total_count int,
  has_next_page boolean
);

create function get_recipes_by_category_ids (
  search_term text,
  category_groups jsonb,
  page_number int,
  page_size int
) returns recipes_page_info as $$
declare
    total_count int := 0;
    recipes_result recipe_preview[];
    page_info recipes_page_info;
    is_empty_categories boolean := coalesce(jsonb_array_length(category_groups), 0) = 0;
    is_empty_search_term boolean := search_term is null or search_term = '';
    recipes_query text := '';
    count_query text := '';
    category_condition text := '';
    subquery text := '';
    subcategories jsonb;
    i int;
    j int;
    join_statements text := '';
    where_condition text :='';
begin
    raise log 'category_groups %', category_groups;
    raise log 'is_empty_categories %', is_empty_categories;
    -- Constructing filter logic based on category groups
    if NOT is_empty_categories then
        for i in 1..jsonb_array_length(category_groups) loop
            subcategories := category_groups->(i-1);
            subquery := 'select recipe_id from recipes_categories where category_id in (';

            for j in 1..jsonb_array_length(subcategories) loop
                subquery := subquery || quote_literal(subcategories->>j-1);
                if j < jsonb_array_length(subcategories) then
                    subquery := subquery || ', ';
                end if;
            end loop;

            subquery := subquery || ')';
            if i = 1 then
                category_condition := 'r.id in (' || subquery || ')';
            else
                category_condition := category_condition || ' and r.id in (' || subquery || ')';
            end if;
        end loop;
    end if;

    -- Join statements for the main query and the total count
    join_statements := '      
      left join recipes_categories rc on r.id = rc.recipe_id
      left join recipes_ingredients ri on r.id = ri.recipe_id
      left join ingredients i on ri.ingredient_id = i.id
    ';

    -- Where condition
    where_condition := 'where ';
    
    if NOT is_empty_categories then
        where_condition := where_condition || category_condition || ' and ';
    end if;

    if is_empty_categories then
        where_condition := where_condition || '(' || 
            'position(' || quote_literal(search_term) || ' in r.name) > 0 or ' ||
            'r.name % ' || quote_literal(search_term) || ' or ' ||
            'i.name % ' || quote_literal(search_term) || ') ';
    else
        where_condition := rtrim(where_condition, ' and ');
    end if;

    -- Construct the full dynamic query
    recipes_query := '
    -- Create a similaraity score for searching recipes vs ingredients 
    with similarity_scores as (
      select 
          r.id, 
          r.name, 
          r.image_url,
          max(case when ' || is_empty_search_term || ' then null 
              else similarity(r.name, ' || quote_literal(search_term) || ') 
          end) as recipe_sim_score,
          max(case when ' || is_empty_search_term || ' then null 
              else similarity(i.name, ' || quote_literal(search_term) || ') 
          end) as ingredient_sim_score
      from recipes r
        ' || join_statements || '
        ' || where_condition || ' 
        group by r.id, r.name, r.image_url
    ),
    -- Order the fetched recipes alphabetically and based on the similarity scores. Recipe names with a certain term take priority with ingredients with the same name
    ordered_recipes as (
        select 
            id, 
            name, 
            image_url
        from similarity_scores
        order by         
            recipe_sim_score desc,
            ingredient_sim_score desc,
            name asc
        limit ' || page_size || '
        offset (' || page_number || ' - 1) * ' || page_size || '
    )
    select array_agg(row(id, name, image_url)::recipe_preview) 
    from ordered_recipes;';

    -- Construct the dynamic query for calculating total count
    count_query := '
    select count(distinct r.id)
    from recipes r
    ' || join_statements || '
    ' || where_condition || ';';

    -- Execute the dynamic query for fetching recipes
    EXECUTE recipes_query INTO recipes_result;

    -- Execute the dynamic query for calculating total count
    EXECUTE count_query INTO total_count;

    -- Construct the dynamic query for calculating total count
    count_query := '
    select count(distinct r.id)
    from recipes r
    ' || join_statements || '
    ' || where_condition || ';';

    -- Assign and return page_info
    page_info := ROW(
        recipes_result, 
        total_count, 
        total_count > page_size * page_number
    )::recipes_page_info;

    RETURN page_info;
end;
$$ language plpgsql;