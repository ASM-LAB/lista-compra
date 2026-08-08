import fs from 'fs';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://izqubzbaiuknewrnbrsl.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_3-aRTioL3jsIjARu_WRmQQ_FUt_8JAi";

const args = process.argv.slice(2);
if (args.length === 0) {
    console.error("Uso: node importar_csv.js <usuario_token>");
    process.exit(1);
}

const usuarioToken = args[0];
console.log(`Iniciando importación para el usuario con token: "${usuarioToken}"...`);

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

function parseCSV(content) {
    const lines = content.trim().split('\n');
    if (lines.length <= 1) return [];

    const headers = lines[0].split(',');
    const results = [];

    for (let i = 1; i < lines.length; i++) {
        const line = lines[i].trim();
        if (!line) continue;

        // Suponemos un formato CSV simple sin comas internas complejas en las celdas
        const parts = line.split(',');
        const row = {};
        headers.forEach((header, index) => {
            row[header.trim()] = parts[index] ? parts[index].trim() : '';
        });
        results.push(row);
    }
    return results;
}

try {
    const csvContent = fs.readFileSync('productos_rows.csv', 'utf8');
    const rows = parseCSV(csvContent);

    if (rows.length === 0) {
        console.log("No se encontraron productos para importar.");
        process.exit(0);
    }

    console.log(`Se encontraron ${rows.length} productos en el CSV.`);

    const productosAInsertar = rows.map((row, index) => {
        return {
            id: parseInt(row.id, 10) || (Date.now() + index),
            usuario_token: usuarioToken,
            nombre: row.nombre,
            seleccionado: row.seleccionado === 'true',
            tipo: row.tipo || 'otros',
            cantidad: 1,
            orden: index + 1
        };
    });

    // Insertar registros en Supabase
    const { data, error } = await supabase
        .from('productos')
        .insert(productosAInsertar);

    if (error) {
        console.error("Error al importar productos a Supabase:", error);
        process.exit(1);
    } else {
        console.log(`¡Súper! Se han importado correctamente ${productosAInsertar.length} productos para el token "${usuarioToken}".`);
    }

} catch (err) {
    console.error("Error de lectura o ejecución:", err);
    process.exit(1);
}
