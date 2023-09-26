alter table equipments enable row level security;

drop policy if exists "Equipments are viewable by everyone." on equipments;

create policy "Equipments are viewable by everyone." on equipments for
select
  to authenticated,
  anon using (true);