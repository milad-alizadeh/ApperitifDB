-- Set the similarity threshold for pg_trgm.
SET
  pg_trgm.similarity_threshold = 0.5;


-- Drop the function if it already exists
drop function if exists get_recipes_by_category_ids (uuid[], int, int);


-- Drop the custom types if they already exist.
drop type if exists recipes_page_info;


-- Drop the recipe_preview type if it already exists.
drop type if exists recipe_preview;


-- Define a custom type to represent a recipe preview.
create type recipe_preview as (id uuid, name text, image_url text);


-- Define a custom type for the function's return value
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
    -- Flag to check if category_ids is empty.
    is_empty_categories boolean := coalesce(array_length(category_ids, 1), 0) = 0;
    -- Flag to check if search_term is empty.
    is_empty_search_term boolean := search_term IS NULL OR search_term = '';
begin
    -- Using a CTE (Common Table Expression) for ordered recipes.
    -- This fetches distinct recipes (based on given category IDs and search_term) in a paginated manner.
    with ordered_recipes as (
        select distinct r.id, r.name, r.image_url
        from recipes r
        left join recipes_categories rc on r.id = rc.recipe_id
        where (is_empty_categories or rc.category_id = any(category_ids))
        and (is_empty_search_term or r.name % search_term)
        order by         
          case when is_empty_search_term then null else similarity(r.name, search_term) end desc,
          r.name asc
        limit page_size
        offset (page_number - 1) * page_size
    )
    -- Populate the recipes_result from the CTE.
    select array_agg(row(id, name, image_url)::recipe_preview) 
    into recipes_result
    from ordered_recipes;

    -- Compute the total count of matching recipes.
    select count(distinct r.id)
    into total_count
    from recipes r
    left join recipes_categories rc on r.id = rc.recipe_id
    where (is_empty_categories or rc.category_id = any(category_ids))
    and (is_empty_search_term or r.name % search_term);

    -- Assign values to the custom return type: recipes_page_info.
    page_info := row(
        recipes_result, 
        total_count, 
        total_count > page_size * page_number
    )::recipes_page_info;

    -- Return the computed page info.
    return page_info;
end;
$$ language plpgsql;