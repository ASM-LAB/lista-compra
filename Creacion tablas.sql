-- Crear la tabla de productos
create table public.productos (
  id bigint not null,
  nombre text not null,
  seleccionado boolean null default false,
  tipo character varying(50) null default 'otros'::character varying,
  cantidad integer not null default 1,
  orden integer not null default 0,
  constraint productos_pkey primary key (id)
) TABLESPACE pg_default;

-- Habilitar el tiempo real para esta tabla
alter publication supabase_realtime add table productos;

-- (Opcional) Desactivar la seguridad estricta para pruebas sencillas sin login
alter table productos enable row level security;
create policy "Acceso público total" on productos for all using (true) with check (true);


