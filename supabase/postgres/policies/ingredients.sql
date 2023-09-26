alter table ingredients enable row level security;

drop policy if exists "Ingredients are viewable by everyone." on ingredients;

create policy "Ingredients are viewable by everyone." on ingredients for
select
  to authenticated,
  anon using (true);