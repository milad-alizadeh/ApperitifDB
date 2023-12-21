create
or replace function create_or_update_ingredient_brand (payload json) returns uuid as $$
declare
    v_ingredient_brand_id uuid; -- renamed ingredient_id to avoid conflict with column names
    is_new_ingredient_brand boolean;
    ingredient_category json;
begin
    -- determine if it's a new ingredient or an update
    is_new_ingredient_brand := (payload ->> 'id') is null;

    -- insert or update the ingredient
    if is_new_ingredient_brand then
        insert into ingredient_brands (name, description, url, ingredient_id)
        values (
            payload ->> 'name', 
            payload ->> 'description', 
            payload ->> 'url',
            payload ->> 'ingredient_id'
        )
        returning ingredient_brands.id into v_ingredient_brand_id;
    else
        v_ingredient_brand_id := (payload ->> 'id')::uuid;
        update ingredient_brands
        set name = payload ->> 'name',
            description = payload ->> 'description',
            url = payload ->> 'url',
            ingredient_id = payload ->> 'ingredient_id'
        where ingredient_brands.id = v_ingredient_brand_id;
    end if;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;