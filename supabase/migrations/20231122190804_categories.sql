alter table categories enable row level security;

drop policy if exists "Categories are viewable by everyone." on categories;

create policy "Categories are viewable by everyone." on categories for
select
  to authenticated,
  anon using (true);

drop policy if exists "Categories are editable by admin users." on categories;

create policy "Categories are editable by admin users." on categories for all to authenticated using (
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