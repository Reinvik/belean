-- 1. Agregar columna last_login a la tabla profiles
alter table public.profiles 
add column if not exists last_login timestamp with time zone;

-- 2. Función para sincronizar el login desde auth.users a public.profiles
create or replace function public.handle_user_login()
returns trigger as $$
begin
  update public.profiles
  set last_login = new.last_sign_in_at
  where id = new.id;
  return new;
end;
$$ language plpgsql security definer;

-- 3. Trigger que se ejecuta cuando el usuario se loguea (cambia last_sign_in_at)
drop trigger if exists on_auth_user_login on auth.users;
create trigger on_auth_user_login
  after update of last_sign_in_at on auth.users
  for each row execute procedure public.handle_user_login();

-- 4. Rellenar datos históricos (Backfill)
update public.profiles
set last_login = auth.users.last_sign_in_at
from auth.users
where public.profiles.id = auth.users.id;

-- 5. Asegurar permisos de lectura (aunque select * ya debería incluirlo si policies lo permiten)
-- Las policies existentes de "Ver perfiles" ya cubren select *
