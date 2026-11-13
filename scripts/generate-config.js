const fs = require('node:fs');
const path = require('node:path');

const envPath = path.join(__dirname, '..', '.env.local');
const fileEnv = {};

if (fs.existsSync(envPath)) {
    const contents = fs.readFileSync(envPath, 'utf8');
    for (const line of contents.split(/\r?\n/)) {
        const match = line.match(/^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*?)\s*$/);
        if (!match || match[1].startsWith('#')) continue;
        fileEnv[match[1]] = match[2].replace(/^("(.*)"|'(.*)')$/, (_, _quoted, doubleQuoted, singleQuoted) => doubleQuoted ?? singleQuoted);
    }
}

const supabaseUrl = process.env.SUPABASE_URL || fileEnv.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || fileEnv.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
    console.error('Faltan SUPABASE_URL o SUPABASE_ANON_KEY. Define ambas variables de entorno o añádelas a .env.local.');
    process.exit(1);
}

const config = `window.APP_CONFIG = Object.freeze(${JSON.stringify({ supabaseUrl, supabaseAnonKey })});\n`;
const outputPath = path.join(__dirname, '..', 'config.js');
fs.writeFileSync(outputPath, config, 'utf8');
console.log('Configuración de Supabase generada en config.js.');
