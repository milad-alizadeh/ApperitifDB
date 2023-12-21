create
or replace function create_or_update_ingredient (payload json) returns uuid as $$
declare
    v_ingredient_id uuid; -- renamed ingredient_id to avoid conflict with column names
    is_new_ingredient boolean;
    ingredient_category json;
    ingredient_brand json;
begin
    -- determine if it's a new ingredient or an update
    is_new_ingredient := (payload ->> 'id') is null;

    -- insert or update the ingredient
    if is_new_ingredient then
        insert into ingredients (name, description, is_draft)
        values (payload ->> 'name', payload ->> 'description', (payload ->> 'isDraft')::boolean)
        returning ingredients.id into v_ingredient_id;
    else
        v_ingredient_id := (payload ->> 'id')::uuid;
        update ingredients
        set name = payload ->> 'name',
            description = payload ->> 'description',
            is_draft = (payload ->> 'isDraft')::boolean
        where ingredients.id = v_ingredient_id;
    end if;

    -- delete existing relations if it's an update
    if not is_new_ingredient then
        delete from ingredients_categories where ingredients_categories.ingredient_id = v_ingredient_id;
        update ingredient_brands 
        set ingredient_id = null
        where ingredient_brands.ingredient_id = v_ingredient_id;
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

    -- update ingredient brands
    for ingredient_brand in select * from json_array_elements(payload -> 'ingredientBrands')
    loop
        update ingredient_brands 
        set ingredient_id = v_ingredient_id
        where ingredient_brands.id = (ingredient_brand ->> 'id')::uuid;
    end loop;

    return v_ingredient_id;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;