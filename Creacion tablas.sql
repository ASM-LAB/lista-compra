-- Crear la tabla de productos para soporte multiusuario
create table public.productos (
  id bigint not null,
  usuario_token text not null,
  nombre text not null,
  seleccionado boolean null default false,
  tipo character varying(50) null default 'otros'::character varying,
  cantidad integer not null default 1,
  orden integer not null default 0,
  constraint productos_pkey primary key (id, usuario_token)
) TABLESPACE pg_default;

-- Habilitar el tiempo real para esta tabla
alter publication supabase_realtime add table productos;

-- Desactivar la seguridad estricta para pruebas sencillas sin login o bajo control de tokens en el frontend
alter table productos enable row level security;
create policy "Acceso público total" on productos for all using (true) with check (true);
