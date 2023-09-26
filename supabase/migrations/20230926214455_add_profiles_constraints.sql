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

-- Set up Row Level Security (RLS)
alter table profiles enable row level security;

drop policy if exists "Users can view their own profile." on profiles;

drop policy if exists "Users can insert their own profile." on profiles;

drop policy if exists "Users can update own profile." on profiles;

alter table profiles enable row level security;

create policy "Users can access their own favourite recipes." on profiles for all to authenticated using (auth.uid () = id)
with
  check (auth.uid () = id);

-- This trigger automatically creates a profile entry when a new user signs up via Supabase Auth.
create
or replace function public.handle_new_user () returns trigger as $$
begin
  insert into public.profiles (id, email, name)
  values (new.id, new.raw_user_meta_data->>'email', new.raw_user_meta_data->>'name');
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users for each row
execute procedure public.handle_new_user ();