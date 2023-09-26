alter table units enable row level security;

drop policy if exists "Units are viewable by everyone." on units;

create policy "Units are viewable by everyone." on units for
select
  to authenticated,
  anon using (true);