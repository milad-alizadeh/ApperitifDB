create
or replace function does_email_exist (email text) returns boolean language plpgsql security definer
set
  search_path = public stable as $$
BEGIN
    -- Directly check for a matching email
    PERFORM u.email FROM auth.users u WHERE u.email = lower($1);

    -- Return true if a match was found, otherwise return false
    RETURN FOUND;
END;
$$;