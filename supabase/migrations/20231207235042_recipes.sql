alter table recipes enable row level security;

drop policy if exists "Recipes are viewable by everyone." on recipes;

create policy "Recipes are viewable by everyone." on recipes for
select
  to authenticated,
  anon using (recipes.is_draft = false);

drop policy if exists "Recipes are editable by admin users." on recipes;

create policy "Recipes are editable by admin users." on recipes for all to authenticated using (
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