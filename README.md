# Lista de la Compra Compartida (lista-compra)

Una aplicación web progresiva (PWA) de **Lista de la Compra Compartida** diseñada para sincronizar en tiempo real los artículos del supermercado que necesitan comprarse. Está optimizada tanto para dispositivos móviles como para navegadores de escritorio.

## Características Principales

La aplicación se estructura en cuatro vistas principales, accesibles mediante la barra de navegación inferior:

1. **Comprar (Lista Compra)**:
   - Muestra los elementos seleccionados para la compra, organizados por su respectiva categoría.
   - Permite marcar/desmarcar los elementos según se van metiendo al carrito de la compra.
   - Muestra las cantidades añadidas de cada producto (por ejemplo, `x2`, `x3`).

   ![Vista Comprar](images/vista_comprar.png)

2. **Editar (Lista General)**:
   - Muestra la lista completa de todos los productos disponibles en la base de datos agrupados por categorías.
   - Permite seleccionar o deseleccionar productos individuales y cambiar su cantidad (de 1 a 12 unidades) mediante selectores.
   - Incluye una función para ordenar los elementos dentro de cada categoría mediante arrastrar y soltar (**Drag and Drop** nativo). El orden modificado se guarda de forma persistente.
   - Opción rápida de "Seleccionar todos" / "Deseleccionar todos" por categoría. Al deseleccionar una categoría entera, las cantidades de sus elementos se restablecen automáticamente a 1.

   ![Vista Editar](images/vista_editar.png)

3. **Añadir**:
   - Formulario sencillo para añadir un nuevo producto indicando su nombre y su categoría/tipología.
   - Las categorías se cargan de forma dinámica (por ejemplo: Carnes, Pescado, Droguería, Lácteos, Verduras y Frutas, Conservas, legumbres y pastas, Otros).

   ![Vista Añadir](images/vista_anadir.png)

4. **Borrar**:
   - Permite eliminar de manera definitiva cualquier producto de la base de datos de la aplicación.

   ![Vista Borrar](images/vista_borrar.png)

## Tecnologías Utilizadas

- **Frontend**: HTML5, CSS3 (con variables personalizadas, diseño responsive y CSS adaptativo) y JavaScript nativo (ES6+).
- **Base de Datos & Tiempo Real**: **Supabase**, utilizando el cliente JS para la sincronización y persistencia de datos inmediata a través de canales en tiempo real (`supabase_realtime`).
- **PWA (Progressive Web App)**: Configurada mediante un archivo `manifest.json` y meta-etiquetas compatibles para permitir su instalación en dispositivos móviles Android e iOS como aplicación nativa.

## Estructura de Archivos

- `index.html`: Contiene toda la estructura visual, estilos CSS responsivos y la lógica JS de la interfaz y la integración con Supabase.
- `tipos.js`: Módulo que define y exporta las distintas categorías disponibles para clasificar los productos de la compra (`TIPOS_COMPRA`).
- `manifest.json`: Archivo de manifiesto de la aplicación web que define cómo se comporta cuando se instala en el dispositivo móvil del usuario.
- `icono.png`: Icono de la aplicación utilizado para el acceso directo y la pantalla de carga.
- `Creacion tablas.sql`: Sentencias SQL para inicializar la base de datos de Supabase, habilitar el tiempo real y configurar el Row Level Security (RLS).
- `productos_rows.csv`: Archivo de datos iniciales / de muestra con productos habituales ya clasificados por categorías.

## Temas Pendientes / Road Map
1. Botón inicializar en editar.
2. Ver cómo evitar la hibernación de Supabase.
