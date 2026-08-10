# Lista de la Compra Compartida (lista-compra)

Una aplicación web progresiva (PWA) de **Lista de la Compra Compartida** diseñada para sincronizar en tiempo real los artículos del supermercado que necesitan comprarse. Está optimizada tanto para dispositivos móviles como para navegadores de escritorio.

## Características Principales

La aplicación se estructura en vistas intuitivas accesibles mediante la barra de navegación inferior simplificada, además de un sistema de gestión multiusuario por familias y un menú desplegable de opciones extendidas:

### Concepto de Familia (Listas Independientes)
Para garantizar la independencia y privacidad de las listas, la aplicación utiliza el concepto de **Familia o Agrupación**. Esto permite generar y mantener listas de la compra totalmente independientes para cada hogar o grupo:
- **Asociación inicial**: Al acceder por primera vez, la aplicación muestra una interfaz interactiva de conexión solicitando el nombre de su familia o grupo.
- **Sincronización dedicada**: Solo se muestran, modifican o eliminan los productos asociados a dicho identificador familiar en Supabase.
- **Historial de Selección**: El sistema registra automáticamente en un historial local (`localStorage`) todas las familias utilizadas anteriormente. Esto permite reconectarse con un solo clic a cualquier grupo sin tener que escribir su nombre cada vez.
- **Gestión de Sugerencias**: Si deseas limpiar tu lista de selección local de familias que ya no utilizas, puedes borrarlas individualmente de la vista utilizando el botón de eliminación (**×**) que aparece a la derecha de cada sugerencia (esta acción es únicamente local y no borra los datos de la base de datos).
- **Acceso rápido**: A través del botón **Familia** en la barra de navegación inferior, puedes abrir este modal en cualquier momento para alternar de forma cómoda entre tus distintas listas.

### Vistas de la Aplicación

La barra de navegación principal se ha simplificado a 3 botones principales y un menú desplegable de opciones secundarias, ofreciendo una experiencia limpia y centrada en la compra:

1. **Comprar (Lista Compra)**:
   - Muestra los elementos seleccionados para la compra de la familia activa, organizados por su respectiva categoría.
   - Permite marcar/desmarcar los elementos según se van metiendo al carrito de la compra.
   - Muestra las cantidades añadidas de cada producto (por ejemplo, `x2`, `x3`).

   ![Vista Comprar](images/vista_comprar.png)

2. **Editar (Lista General)**:
   - Muestra la lista completa de todos los productos disponibles para la familia, agrupados por categorías.
   - Permite seleccionar o deseleccionar productos individuales y cambiar su cantidad (de 1 a 12 unidades) mediante selectores.
   - Incluye una función para ordenar los elementos dentro de cada categoría mediante arrastrar y soltar (**Drag and Drop** nativo). El orden modificado se guarda de forma persistente.
   - Opción rápida de "Seleccionar todos" / "Deseleccionar todos" por categoría.

   ![Vista Editar](images/vista_editar.png)

3. **Añadir**:
   - Formulario sencillo para añadir un nuevo producto indicando su nombre y su categoría/tipología.
   - Las categorías se cargan de forma totalmente dinámica desde la base de datos o almacenamiento local.

   ![Vista Añadir](images/vista_anadir.png)

4. **Menú "Más" (Opciones Extendidas)**:
   - Al pulsar el botón "Más ☰", se despliega un popover flotante con las siguientes opciones:
     - **🗑️ Borrar**: Vista dedicada para eliminar de manera definitiva cualquier producto de la base de datos de la familia activa. ![Vista Borrar](images/vista_borrar.png)
     - **🏷️ Categorías**: Vista de mantenimiento de categorías para añadir nuevas clasificaciones de productos, eliminarlas (reubicando sus artículos asociados en la categoría 'Otros') y ordenarlas de forma persistente utilizando **Drag and Drop** nativo.
     - **👪 Familia**: Modal de cambio rápido y gestión del historial de familias.

## Tecnologías Utilizadas

- **Frontend**: HTML5, CSS3 (con variables personalizadas, diseño responsive y CSS adaptativo) y JavaScript nativo (ES6+).
- **Base de Datos & Tiempo Real**: **Supabase**, utilizando el cliente JS para la sincronización y persistencia de datos inmediata a través de canales en tiempo real (`supabase_realtime`) filtrados por familia.
- **PWA (Progressive Web App)**: Configurada mediante un archivo `manifest.json` y meta-etiquetas compatibles para permitir su instalación en dispositivos móviles Android e iOS como aplicación nativa.

## Estructura de Archivos

- `index.html`: Contiene toda la estructura visual, estilos CSS responsivos con adaptaciones para zonas seguras de dispositivos móviles (como el indicador de inicio de iOS) y la lógica JS de la interfaz y la integración con Supabase filtrada por la familia actual en `localStorage`.
- `Creacion categorias.sql`: Sentencias SQL para inicializar la tabla de categorías, activar su tiempo real en Supabase, y poblar con datos predeterminados para familias de prueba.
- `manifest.json`: Archivo de manifiesto de la aplicación web que define cómo se comporta cuando se instala en el dispositivo móvil del usuario.
- `icono.png`: Icono de la aplicación utilizado para el acceso directo y la pantalla de carga.
- `Creacion tablas.sql`: Sentencias SQL para inicializar la base de datos de Supabase, habilitar el tiempo real y configurar el Row Level Security (RLS). La tabla incluye la columna `familia text null` para filtrar los registros por agrupación familiar.
- `productos_rows.csv`: Archivo de datos iniciales / de muestra con productos habituales ya clasificados por categorías.

## Modelo de Datos (Esquema de Base de Datos)

### Tabla `productos`
* `id` (`bigint`): Identificador único del producto.
* `nombre` (`text`): Nombre del artículo.
* `seleccionado` (`boolean`): Estado de selección.
* `tipo` (`character varying(50)`): Categoría del artículo (asociada al `id` de la tabla `categorias`).
* `cantidad` (`integer`): Número de unidades deseadas (de 1 a 12).
* `orden` (`integer`): Orden del elemento dentro de su respectiva categoría.
* `familia` (`text`): Identificador de la familia para aislamiento de datos.

### Tabla `categorias`
* `id` (`text`): Identificador simplificado y normalizado de la categoría (p. ej. `'pescado'`).
* `label` (`text`): Nombre legible mostrado en pantalla (p. ej. `'Pescado'`).
* `orden` (`integer`): Posición para el ordenamiento de las categorías.
* `familia` (`text`): Identificador de la familia asociada.

## Próximas Tareas / Road Map

1. **Soporte offline extendido**: Mejorar la sincronización local en Service Workers ante cortes de conexión a Internet.
2. **Notificaciones Push**: Avisar a otros miembros de la familia en tiempo real cuando se añade un producto urgente o se completa la compra.
