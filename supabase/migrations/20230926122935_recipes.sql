alter table recipes enable row level security;

drop policy if exists "Recipes are viewable by everyone." on recipes;

create policy "Recipes are viewable by everyone." on recipes for
select
  to authenticated,
  anon using (true);