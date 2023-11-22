alter table ingredients_categories enable row level security;

drop policy if exists "Ingredients Categories are viewable by everyone." on ingredients_categories;

create policy "Ingredients Categories are viewable by everyone." on ingredients_categories for
select
  to authenticated,
  anon using (true);

drop policy if exists "Ingredients Categories are editable by admin users." on ingredients_categories;

create policy "Ingredients Categories are editable by admin users." on ingredients_categories for all to authenticated using (
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