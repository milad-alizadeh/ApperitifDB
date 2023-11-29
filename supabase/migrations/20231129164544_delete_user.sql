create
or replace function delete_user () returns boolean language plpgsql as $$
begin
   delete from auth.users where id = auth.uid();
   if found then
       return true;
   else
       return false;
   end if;
end;
$$;