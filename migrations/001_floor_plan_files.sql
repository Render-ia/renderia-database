-- Migración 001: tabla para guardar la imagen de cada plano.
-- Es segura de correr varias veces. El backend también la ejecuta al arrancar.
CREATE TABLE IF NOT EXISTS floor_plan_files (
    floor_plan_id BIGINT      PRIMARY KEY REFERENCES floor_plans(id) ON DELETE CASCADE,
    content_type  VARCHAR(50) NOT NULL,
    data          BYTEA       NOT NULL
);
