alter table equipment enable row level security;

drop policy if exists "Equipment is viewable by everyone." on equipment;

create policy "Equipment is viewable by everyone." on equipment for
select
  to authenticated,
  anon using (true);

drop policy if exists "Equipment is editable by admin users." on equipment;

create policy "Equipment is editable by admin users." on equipment for all to authenticated using (
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