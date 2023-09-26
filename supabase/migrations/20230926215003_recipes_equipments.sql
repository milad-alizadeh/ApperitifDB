alter table recipes_equipments enable row level security;

drop policy if exists "Recipes Equipments are viewable by everyone." on recipes_equipments;

create policy "Recipes Equipments are viewable by everyone." on recipes_equipments for
select
  to authenticated,
  anon using (true);