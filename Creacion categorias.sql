-- Crear la tabla de categorías
create table public.categorias (
  id text not null,
  label text not null,
  orden integer not null default 0,
  familia text not null,
  constraint categorias_pkey primary key (id, familia)
) TABLESPACE pg_default;

-- Habilitar el tiempo real para esta tabla
alter publication supabase_realtime add table categorias;

-- Configurar Seguridad de Nivel de Fila (RLS) similar a la tabla productos
alter table categorias enable row level security;
create policy "Acceso público total" on categorias for all using (true) with check (true);

-- Insertar datos por defecto para la familia "Alfredo y Gina"
insert into public.categorias (id, label, orden, familia) values
  ('carnes, aves y fiambres', 'Carnes, aves y fiambres', 1, 'Alfredo y Gina'),
  ('pescado', 'Pescado', 2, 'Alfredo y Gina'),
  ('drogueria y limpieza', 'Droguería y limpieza', 3, 'Alfredo y Gina'),
  ('lacteos y huevos', 'Lácteos y huevos', 4, 'Alfredo y Gina'),
  ('verduras y frutas', 'Verduras y frutas', 5, 'Alfredo y Gina'),
  ('conservas, legumbres y pastas', 'Conservas, legumbres y pastas', 6, 'Alfredo y Gina'),
  ('panaderia y desayuno', 'Panadería y desayuno', 7, 'Alfredo y Gina'),
  ('otros', 'Otros', 8, 'Alfredo y Gina'),
  ('carrefour', 'Carrefour', 9, 'Alfredo y Gina');

-- Insertar datos por defecto para la familia "Carlos y Belen"
insert into public.categorias (id, label, orden, familia) values
  ('carnes, aves y fiambres', 'Carnes, aves y fiambres', 1, 'Carlos y Belen'),
  ('pescado', 'Pescado', 2, 'Carlos y Belen'),
  ('drogueria y limpieza', 'Droguería y limpieza', 3, 'Carlos y Belen'),
  ('lacteos y huevos', 'Lácteos y huevos', 4, 'Carlos y Belen'),
  ('verduras y frutas', 'Verduras y frutas', 5, 'Carlos y Belen'),
  ('conservas, legumbres y pastas', 'Conservas, legumbres y pastas', 6, 'Carlos y Belen'),
  ('panaderia y desayuno', 'Panadería y desayuno', 7, 'Carlos y Belen'),
  ('otros', 'Otros', 8, 'Carlos y Belen'),
  ('carrefour', 'Carrefour', 9, 'Carlos y Belen');
