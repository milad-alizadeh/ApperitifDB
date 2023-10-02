alter table app_content enable row level security;

drop policy if exists "Contents are viewable by everyone." on app_content;

create policy "Contents are viewable by everyone." on app_content for
select
  to authenticated,
  anon using (true);