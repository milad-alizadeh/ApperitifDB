alter table profiles_ingredients enable row level security;

create policy "Users can access ingredients in their bar." on profiles_ingredients for all to authenticated using (auth.uid () = profile_id)
with
  check (auth.uid () = profile_id);