alter table recipes_equipment enable row level security;

drop policy if exists "Recipes Equipment are viewable by everyone." on recipes_equipment;

create policy "Recipes Equipment are viewable by everyone." on recipes_equipment for
select
  to authenticated,
  anon using (true);

drop policy if exists "Recipes Equipment are editable by admin users." on recipes_equipment;

create policy "Recipes Equipment are editable by admin users." on recipes_equipment for all to authenticated using (
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