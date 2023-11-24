create
or replace function create_or_update_ingredient (payload json) returns uuid as $$
declare
    v_ingredient_id uuid; -- renamed ingredient_id to avoid conflict with column names
    is_new_ingredient boolean;
    ingredient_category json;
begin
    -- determine if it's a new ingredient or an update
    is_new_ingredient := (payload ->> 'id') is null;

    -- insert or update the ingredient
    if is_new_ingredient then
        insert into ingredients (name, description)
        values (payload ->> 'name', payload ->> 'description')
        returning ingredients.id into v_ingredient_id;
    else
        v_ingredient_id := (payload ->> 'id')::uuid;
        update ingredients
        set name = payload ->> 'name',
            description = payload ->> 'description'
        where ingredients.id = v_ingredient_id;
    end if;

    -- delete existing relations if it's an update
    if not is_new_ingredient then
        delete from ingredients_categories where ingredients_categories.ingredient_id = v_ingredient_id;
    end if;

    -- insert ingredient categories
    for ingredient_category in select * from json_array_elements(payload -> 'categories')
    loop
        insert into ingredients_categories (ingredient_id, category_id)
        values (
                v_ingredient_id,
                (ingredient_category ->> 'id')::uuid
              );
    end loop;

    return v_ingredient_id;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;