-- Migration 006: elevators found in the building core by the vision detector.
-- Safe to run more than once. The backend also runs it on startup.
INSERT INTO element_types (name, description)
VALUES ('Ascensor', 'Cabina y foso del ascensor en el núcleo del edificio')
ON CONFLICT (name) DO NOTHING;
