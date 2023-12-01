create
or replace function delete_user () returns boolean language plpgsql security definer as $$
declare
    row_count int;
begin
    delete from auth.users where id = auth.uid();
    get diagnostics row_count = row_count;
    if row_count > 0 then
        return true;
    else
        return false;
    end if;
end;
$$;