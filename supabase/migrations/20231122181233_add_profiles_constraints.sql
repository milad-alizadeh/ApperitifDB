do $$ 
BEGIN 
    IF NOT EXISTS (
        SELECT 1 
        FROM pg_constraint 
        WHERE conname = 'fk_auth_users'
    ) THEN 
        ALTER TABLE profiles 
        ADD CONSTRAINT fk_auth_users FOREIGN KEY (id) REFERENCES auth.users (id) ON DELETE CASCADE; 
    END IF; 
END $$;

-- This trigger automatically creates a profile entry when a new user signs up via Supabase Auth.
create
or replace function public.handle_new_user () returns trigger as $$
BEGIN
  INSERT INTO public.profiles (id, role)
  VALUES (NEW.id, 'user');
  RETURN NEW;
END;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users for each row
execute procedure public.handle_new_user ();