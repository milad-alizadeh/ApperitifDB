create
or replace function create_or_update_app_content (payload json) returns uuid as $$
declare
    v_content_id uuid; -- renamed v_content_id to avoid conflict with column names
begin
    -- determine if it's new content or an update
    v_content_id := (payload ->> 'id')::uuid;

    update app_content
    set name = payload ->> 'name',
        content = (payload ->> 'content')::json
    where app_content.id = v_content_id;

    return v_content_id;

exception
    when others then
        -- in case of any exception, rollback the transaction
        raise log 'error occurred: %', sqlerrm;
        raise;
end;
$$ language plpgsql;