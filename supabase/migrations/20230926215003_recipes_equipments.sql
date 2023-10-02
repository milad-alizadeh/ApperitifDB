alter table recipes_equipment enable row level security;

drop policy if exists "Recipes Equipment are viewable by everyone." on recipes_equipment;

create policy "Recipes Equipment are viewable by everyone." on recipes_equipment for
select
  to authenticated,
  anon using (true);