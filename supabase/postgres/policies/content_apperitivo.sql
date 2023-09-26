alter table content_apperitivo enable row level security;

drop policy if exists "Contents are viewable by everyone." on content_apperitivo;

create policy "Contents are viewable by everyone." on content_apperitivo for
select
  to authenticated,
  anon using (true);