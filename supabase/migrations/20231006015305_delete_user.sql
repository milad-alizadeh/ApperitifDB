create
or replace function "delete_user" () returns boolean language plpgsql security definer as $$
BEGIN
   DELETE FROM auth.users WHERE id = auth.uid();
   IF found THEN
       RETURN TRUE;
   ELSE
       RETURN FALSE;
   END IF;
END;
$$;