alter table ingredients enable row level security;

drop policy if exists "Ingredients are viewable by everyone." on ingredients;

create policy "Ingredients are viewable by everyone." on ingredients for
select
  to authenticated,
  anon using (recipes.is_draft = false);

drop policy if exists "Ingredients are editable by admin users." on ingredients;

create policy "Ingredients are editable by admin users." on ingredients for all to authenticated using (
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