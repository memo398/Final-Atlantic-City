const express = require('express');
const router = express.Router();
const db = require('../db'); // Conexión a MySQL

// Obtener todos los clientes
router.get('/', (req, res) => {
    db.query('SELECT * FROM clientes', (error, results) => {
        if (error) return res.status(500).json({ error: 'Error al obtener clientes' });
        res.json(results);
    });
});

// Obtener un cliente por ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM clientes WHERE id = ?', [id], (error, results) => {
        if (error) return res.status(500).json({ error: 'Error al obtener cliente' });
        if (results.length === 0) return res.status(404).json({ error: 'Cliente no encontrado' });
        res.json(results[0]);
    });
});

// Crear un nuevo cliente
router.post('/', (req, res) => {
    const { nombre, email } = req.body;
    db.query('INSERT INTO clientes (nombre, email) VALUES (?, ?)', [nombre, email], (error, result) => {
        if (error) return res.status(500).json({ error: 'Error al agregar cliente' });
        res.json({ id: result.insertId, nombre, email });
    });
});

// Actualizar un cliente
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { nombre, email } = req.body;
    db.query('UPDATE clientes SET nombre=?, email=? WHERE id=?', [nombre, email, id], (error, result) => {
        if (error) return res.status(500).json({ error: 'Error al actualizar cliente' });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'Cliente no encontrado' });
        res.json({ mensaje: 'Cliente actualizado' });
    });
});

// Eliminar un cliente
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM clientes WHERE id=?', [id], (error, result) => {
        if (error) return res.status(500).json({ error: 'Error al eliminar cliente' });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'Cliente no encontrado' });
        res.json({ mensaje: 'Cliente eliminado' });
    });
});

module.exports = router;
