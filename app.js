// Archivo principal del backend que configura el servidor con Express.js.
// Se conecta con: db.js para acceder a la base de datos y responde a las solicitudes de main.js.
// También sirve los archivos HTML desde la carpeta "public".

const express = require('express');
const app = express();
const PORT = 4000;

// Middleware para procesar JSON
app.use(express.json());

// Importar rutas
const clientesRoutes = require('./rutas/clientes');

app.use('/api/clientes', clientesRoutes);

// Servidor escuchando
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
