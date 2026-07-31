-- Crear la tabla de productos
create table productos (
  id bigint primary key,
  nombre text not null,
  seleccionado boolean default false
);

-- Habilitar el tiempo real para esta tabla
alter publication supabase_realtime add table productos;

-- (Opcional) Desactivar la seguridad estricta para pruebas sencillas sin login
alter table productos enable row level security;
create policy "Acceso público total" on productos for all using (true) with check (true);