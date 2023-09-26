alter table categories enable row level security;

drop policy if exists "Categories are viewable by everyone." on categories;

create policy "Categories are viewable by everyone." on categories for
select
  to authenticated,
  anon using (true);