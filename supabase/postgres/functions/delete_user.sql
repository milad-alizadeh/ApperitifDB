create
or replace function "deleteUser" () returns void language sql security definer as $$
   delete from auth.users where id = auth.uid();
$$;