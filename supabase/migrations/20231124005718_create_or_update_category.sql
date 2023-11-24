create
or replace function create_or_update_category (payload json) returns uuid as $$
declare
    v_category_id uuid; -- renamed v_category_id to avoid conflict with column names
    is_new_category boolean;
    ingredient_category json;
    recipe_category json;
    subcategory json;
begin
    -- determine if it's a new recipe or an update
    is_new_category := (payload ->> 'id') is null;

    -- insert or update the recipe
    if is_new_category then
        insert into categories (name, image_url)
        values (payload ->> 'name', payload ->> 'imageUrl')
        returning categories.id into v_category_id; -- use the renamed variable
    else
        v_category_id := (payload ->> 'id')::uuid; -- use the renamed variable
        update categories
        set name = payload ->> 'name',
            image_url = payload ->> 'imageUrl'
        where categories.id = v_category_id; -- use the renamed variable
    end if;

    -- delete existing relations if it's an update
    if not is_new_category then
        delete from ingredients_categories where ingredients_categories.category_id = v_category_id;
        delete from recipes_categories where recipes_categories.category_id = v_category_id;
        update categories set parent_id = null where parent_id = v_category_id;
    end if;

    -- insert ingredients categories
    for ingredient_category in select * from json_array_elements(payload -> 'ingredients')
    loop
        insert into ingredients_categories (category_id, ingredient_id)
        values (
                v_category_id,
                (ingredient_category ->> 'id')::uuid
              );
    end loop;

    -- insert recipe categories
    for recipe_category in select * from json_array_elements(payload -> 'recipes')
    loop
        insert into recipes_categories (category_id, recipe_id)
        values (
                v_category_id,
                (recipe_category ->> 'id')::uuid
              );
    end loop;

    -- insert subcategories
    for subcategory in select * from json_array_elements(payload -> 'categories')
    loop
        update categories
        set parent_id = v_category_id
        where categories.id = (subcategory ->> 'id')::uuid; -- corrected to use subcategory
    end loop;

    return v_category_id;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;