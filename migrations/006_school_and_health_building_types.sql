-- Migración 006: tipos de edificación de los proyectos de ejemplo (colegio y centro de salud).
-- Es segura de correr varias veces. El backend también la ejecuta al arrancar (SchemaUpdater).
INSERT INTO building_types (name, description) VALUES
    ('Institución educativa', 'Colegio, escuela o universidad'),
    ('Centro de salud', 'Hospital, clínica o centro de atención médica')
ON CONFLICT (name) DO NOTHING;
