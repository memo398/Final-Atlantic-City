//Archivo que establece la conexión entre la base de datos MYSQL
//se conecta con la app.js para realizar consultas con la base de datos

//Importamos el modulo mysql 
const mysql = require('mysql');

// Creamos la conexión con los datos del servidor de base de datos
const conexion = mysql.createConnection({
    host: '127.0.0.1',   // Dirección del servidor localhost 
    user: 'root',        // Usuario de la base de datos
    password: 'Vanessa28092006',  // Contraseña del usuario
    database: 'Atlantic_City'     // Nombre de la base de datos a la que nos conectaremos
});


// Validamos la conexión y mostramos un mensaje en la consola
conexion.connect(error => {
    if (error) {
        console.log("Error de conexión a la base de datos:", error);
        return;
    }
    console.log("Conectado con éxito a la base de datos Atlantic_City");
});

// Exportamos la conexión para que pueda ser utilizada en app.js
module.exports = conexion;