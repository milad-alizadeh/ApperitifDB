create
or replace function create_trigger_for_table (table_name text) returns void language plpgsql as $$
begin
    execute format('
        create trigger handle_updated_at 
        before update on %I 
        for each row 
        execute procedure moddatetime (updated_at);
    ', table_name);
end;
$$;