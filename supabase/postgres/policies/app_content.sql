alter table app_content enable row level security;

drop policy if exists "Contents are viewable by everyone." on app_content;

create policy "Content are viewable by everyone." on app_content for
select
  to authenticated,
  anon using (true);

drop policy if exists "Content are editable by admin users." on app_content;

create policy "Content are editable by admin users." on app_content for all to authenticated using (
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