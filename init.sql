-- ================================
-- Script de Inicialización de BD
-- ================================

-- Crear tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar datos de ejemplo
INSERT INTO users (name, email) VALUES
    ('Usuario Demo', 'demo@ejemplo.com'),
    ('Admin', 'admin@ejemplo.com')
ON CONFLICT (email) DO NOTHING;
