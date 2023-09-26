alter table steps enable row level security;

drop policy if exists "Steps are viewable by everyone." on steps;

create policy "Steps are viewable by everyone." on steps for
select
  to authenticated,
  anon using (true);