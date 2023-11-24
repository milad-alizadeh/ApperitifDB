create
or replace function create_or_update_equipment (payload json) returns uuid as $$
declare
    v_equipment_id uuid; -- renamed equipment_id to avoid conflict with column names
    is_new_equipment boolean;
    recipe_equipment json;
begin
    -- determine if it's a new e   quipment or an update
    is_new_equipment := (payload ->> 'id') is null;

    -- insert or update the e  quipment
    if is_new_equipment then
        insert into equipment (name, description)
        values (payload ->> 'name', payload ->> 'imageUrl', payload ->> 'description')
        returning equipment.id into v_equipment_id;
    else
        v_equipment_id := (payload ->> 'id')::uuid;
        update equipment
        set name = payload ->> 'name',
            image_url = payload ->> 'imageUrl', 
            description = payload ->> 'description'
        where equipment.id = v_equipment_id;
    end if;

    -- delete existing relations if it's an update
    if not is_new_equipment then
        delete from recipes_equipment where recipes_equipment.equipment_id = v_equipment_id;
    end if;

    -- insert equipment categories
    for recipe_equipment in select * from json_array_elements(payload -> 'recipes')
    loop
        insert into recipes_equipment (equipment_id, recipe_id)
        values (
                v_equipment_id,
                (recipe_equipment ->> 'id')::uuid
              );
    end loop;

    return v_equipment_id;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;