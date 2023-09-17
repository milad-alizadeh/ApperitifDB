-- drop the function if it already exists
drop function if exists search_ingredients (text) cascade;

-- drop the type if it already exists
drop type if exists ingredient_result cascade;

-- create the return type
create type ingredient_result as (id uuid, name text);

-- create the function
create function search_ingredients (search_term text) returns setof ingredient_result as $$
begin
    return query
    select id, name 
    from ingredients 
    left join ingredients_categories ci on ingredients.id = ci.ingredient_id
    where name % search_term
    order by name;
end;
$$ language plpgsql;