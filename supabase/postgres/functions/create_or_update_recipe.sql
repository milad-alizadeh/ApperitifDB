create
or replace function create_or_update_recipe (payload json) returns uuid as $$
declare
    v_recipe_id uuid; -- renamed recipe_id to avoid conflict with column names
    is_new_recipe boolean;
    recipe_ingredient json;
    recipe_category json;
    recipe_equipment json;
    recipe_step json;
begin
    -- determine if it's a new recipe or an update
    is_new_recipe := (payload ->> 'id') is null;

    -- insert or update the recipe
    if is_new_recipe then
        insert into recipes (name, image_url, description, is_draft)
        values (payload ->> 'name', payload ->> 'imageUrl', payload ->> 'description', (payload ->> 'isDraft')::boolean)
        returning recipes.id into v_recipe_id; -- use the renamed variable
    else
        v_recipe_id := (payload ->> 'id')::uuid; -- use the renamed variable
        update recipes
        set name = payload ->> 'name',
            image_url = payload ->> 'imageUrl',
            is_draft = (payload ->> 'isDraft')::boolean,
            description = payload ->> 'description'
        where recipes.id = v_recipe_id; -- use the renamed variable
    end if;

    -- delete existing relations if it's an update
    if not is_new_recipe then
        delete from recipes_ingredients where recipes_ingredients.recipe_id = v_recipe_id;
        delete from recipes_equipment where recipes_equipment.recipe_id = v_recipe_id;
        delete from recipes_categories where recipes_categories.recipe_id = v_recipe_id;
        delete from steps where steps.recipe_id = v_recipe_id;
    end if;

    -- insert recipe ingredients
    for recipe_ingredient in select * from json_array_elements(payload -> 'ingredients')
    loop
        insert into recipes_ingredients (recipe_id, ingredient_id, quantity, unit_id, is_optional)
        values (
                v_recipe_id,
                (recipe_ingredient -> 'ingredient' ->> 'id')::uuid, 
                (recipe_ingredient ->> 'quantity')::real, 
                (recipe_ingredient -> 'unit' ->> 'id')::uuid, 
                (recipe_ingredient ->> 'isOptional')::boolean
              );
    end loop;

    -- insert recipe categories
    for recipe_category in select * from json_array_elements(payload -> 'categories')
    loop
        insert into recipes_categories (recipe_id, category_id)
        values (
                v_recipe_id,
                (recipe_category ->> 'id')::uuid
              );
    end loop;

    -- insert recipe requipment
    for recipe_equipment in select * from json_array_elements(payload -> 'equipment')
    loop
        insert into recipes_equipment (recipe_id, equipment_id)
        values (
                v_recipe_id,
                (recipe_equipment ->> 'id')::uuid
              );
    end loop;

    -- insert recipe steps
    for recipe_step in select * from json_array_elements(payload -> 'steps')
    loop
        insert into steps (recipe_id, number, description)
        values (
                v_recipe_id,
                (recipe_step ->> 'number')::integer,
                (recipe_step ->> 'description')::text
              );
    end loop;

    return v_recipe_id;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;