alter table steps enable row level security;

drop policy if exists "Steps are viewable by everyone." on steps;

create policy "Steps are viewable by everyone." on steps for
select
  to authenticated,
  anon using (true);

drop policy if exists "Steps are editable by admin users." on steps;

create policy "Steps are editable by admin users." on steps for all to authenticated using (
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