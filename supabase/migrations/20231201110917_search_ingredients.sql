-- drop the function if it already exists.
drop function if exists search_ingredients (text) cascade;

-- drop the type if it already exists
drop type if exists ingredient_result cascade;

-- create the return type
create type ingredient_result as (id uuid, name text, description text);

-- create the function
create function search_ingredients (search_term text) returns setof ingredient_result as $$
begin
    return query
    select id, name, description
    from ingredients 
    where (name % search_term or to_tsvector('english', unaccent(description)) @@ to_tsquery('english', unaccent(search_term)))
    order by 
        case 
            when name % search_term then 0
            else 1
        end,
        name;
end;
$$ language plpgsql;