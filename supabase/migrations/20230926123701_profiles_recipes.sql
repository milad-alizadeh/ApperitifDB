alter table profiles_recipes enable row level security;

create policy "Users can access their own favourite recipes." on profiles_recipes for all to authenticated using (auth.uid () = profile_id)
with
  check (auth.uid () = profile_id);