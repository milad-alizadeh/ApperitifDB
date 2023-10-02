alter table equipment enable row level security;

drop policy if exists "Equipment are viewable by everyone." on equipment;

create policy "Equipment are viewable by everyone." on equipment for
select
  to authenticated,
  anon using (true);