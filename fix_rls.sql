
create or replace function public.is_admin()
returns boolean as $$
begin
  return exists (
    select 1 from public.profiles
    where id = auth.uid() and role in ('admin', 'superadmin')
  );
end;
$$ language plpgsql security definer;
