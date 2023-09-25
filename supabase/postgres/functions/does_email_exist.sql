create
or replace function does_email_exist (email text) returns boolean language plpgsql security definer
set
  search_path = public stable as $$
declare
    val text;
begin
    select p.email into val from profiles p where p.email = lower($1);

    if found then
        return true;
    else
        return false;
    end if;
end;
$$;