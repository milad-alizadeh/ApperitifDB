drop policy if exists "Allow admin access to public-images bucket" on storage.objects;

create policy "Allow admin access to public-images bucket" on storage.objects for all to authenticated using (
  exists (
    select
      1
    from
      profiles
    where
      profiles.id = auth.uid ()
      and profiles.role = 'admin'
      and bucket_id = 'public-images'
  )
)
with
  check (
    exists (
      select
        1
      from
        profiles
      where
        profiles.id = auth.uid ()
        and profiles.role = 'admin'
        and bucket_id = 'public-images'
    )
  );