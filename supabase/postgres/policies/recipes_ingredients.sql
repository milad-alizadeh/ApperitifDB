alter table recipes_ingredients enable row level security;

drop policy if exists "Recipes Ingredients are viewable by everyone." on recipes_ingredients;

create policy "Recipes Ingredients are viewable by everyone." on recipes_ingredients for
select
  to authenticated,
  anon using (true);

drop policy if exists "Recipes Ingredients are editable by admin users." on recipes_ingredients;

create policy "Recipes Ingredients are editable by admin users." on recipes_ingredients for all to authenticated using (
  exists (
    select
      1
    from
      profiles
    where
      profiles.id = auth.uid ()
      and profiles.role = 'admin'
  )
)
with
  check (
    exists (
      select
        1
      from
        profiles
      where
        profiles.id = auth.uid ()
        and profiles.role = 'admin'
    )
  );