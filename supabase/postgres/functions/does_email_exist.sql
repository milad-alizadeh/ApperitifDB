create
or replace function does_email_exist (email text) returns boolean language plpgsql security definer
set
  search_path = public stable as $$
declare
    val text;
begin
    select u.email into val from auth.users u where u.email = lower($1);

    if found then
        return true;
    else
        return false;
    end if;
end;
$$;