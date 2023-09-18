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
    category_ids uuid[],
    page_number int,
    page_size int
) returns recipes_page_info as $$
declare
    total_count int;
    recipes_result recipe_preview[];
    page_info recipes_page_info;
    is_empty_categories boolean := coalesce(array_length(category_ids, 1), 0) = 0;
    is_empty_search_term boolean := search_term is null or search_term = '';
begin
    -- compute similarity scores for recipes based on search term.
    with similarity_scores as (
        select 
            r.id, 
            r.name, 
            r.image_url, 
            max(case when is_empty_search_term then null 
                 else similarity(r.name, search_term) 
            end) as recipe_sim_score,
            max(case when is_empty_search_term then null 
                 else similarity(i.name, search_term) 
            end) as ingredient_sim_score
        from recipes r
        left join recipes_categories rc on r.id = rc.recipe_id
        left join recipes_ingredients ri on r.id = ri.recipe_id
        left join ingredients i on ri.ingredient_id = i.id
        where 
            (is_empty_categories or rc.category_id = any(category_ids))
            and (
                is_empty_search_term 
                or position(search_term in r.name) > 0
                or r.name % search_term
                or i.name % search_term
            )
        group by r.id, r.name, r.image_url
    ),
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
        limit page_size
        offset (page_number - 1) * page_size
    )
    -- populate the recipes_result from the cte.
    select array_agg(row(id, name, image_url)::recipe_preview) 
    into recipes_result
    from ordered_recipes;

    -- compute the total count of matching recipes.
    select count(distinct r.id)
    into total_count
    from recipes r
    left join recipes_categories rc on r.id = rc.recipe_id
    left join recipes_ingredients ri on r.id = ri.recipe_id
    left join ingredients i on ri.ingredient_id = i.id
    where 
        (is_empty_categories or rc.category_id = any(category_ids))
        and (
            is_empty_search_term 
            or position(search_term in r.name) > 0
            or r.name % search_term
            or i.name % search_term
        );

    -- assign values to the custom return type: recipes_page_info.
    page_info := row(
        recipes_result, 
        total_count, 
        total_count > page_size * page_number
    )::recipes_page_info;

    -- return the computed page info.
    return page_info;
end;
$$ language plpgsql;