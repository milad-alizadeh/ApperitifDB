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
  insert into public.profiles (id, first_name, last_name, email)
  values (new.id, new.raw_user_meta_data->>'email', new.raw_user_meta_data->>'first_name', new.raw_user_meta_data->>'last_name');
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
after insert on auth.users for each row
execute procedure public.handle_new_user ();

-- -- Set up Storage!
-- insert into storage.buckets (id, name)
--   values ('avatars', 'avatars');
-- -- Set up access controls for storage.
-- -- See https://supabase.com/docs/guides/storage#policy-examples for more details.
-- create policy "Avatar images are publicly accessible." on storage.objects
--   for select using (bucket_id = 'avatars');
-- create policy "Anyone can upload an avatar." on storage.objects
--   for insert with check (bucket_id = 'avatars');
-- create policy "Anyone can update their own avatar." on storage.objects
--   for update using (auth.uid() = owner) with check (bucket_id = 'avatars');