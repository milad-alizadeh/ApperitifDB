alter table recipes_categories enable row level security;

drop policy if exists "Recipes Categories are viewable by everyone." on recipes_categories;

create policy "Recipes Categories are viewable by everyone." on recipes_categories for
select
  to authenticated,
  anon using (true);

drop policy if exists "Recipes Categories are editable by admin users." on recipes_categories;

create policy "Recipes Categories are editable by admin users." on recipes_categories for all to authenticated using (
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