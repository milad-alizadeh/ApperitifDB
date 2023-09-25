alter table profiles
add constraint fk_auth_users foreign key (id) references auth.users (id) on delete cascade;

-- Set up Row Level Security (RLS)
alter table profiles enable row level security;

create policy "Users can view their own profile." on profiles for
select
  using (auth.uid () = id);

create policy "Users can insert their own profile." on profiles for insert
with
  check (auth.uid () = id);

create policy "Users can update own profile." on profiles for
update using (auth.uid () = id);

-- This trigger automatically creates a profile entry when a new user signs up via Supabase Auth.
create function public.handle_new_user () returns trigger as $$
begin
  insert into public.profiles (id, email, name)
  values (new.id, new.raw_user_meta_data->>'email', new.raw_user_meta_data->>'name');
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
after insert on auth.users for each row
execute procedure public.handle_new_user ();