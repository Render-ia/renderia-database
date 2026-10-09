-- =========================================
-- Render.IA - Datos iniciales de catálogos
-- =========================================

INSERT INTO roles (name, description) VALUES
('Administrador', 'Gestiona usuarios, catálogos y modelos de IA'),
('Ingeniero',     'Crea proyectos y analiza planos estructurales'),
('Estudiante',    'Usa la plataforma con fines académicos');

INSERT INTO building_types (name, description) VALUES
('Vivienda unifamiliar', 'Casa para una sola familia'),
('Edificio residencial', 'Edificio de apartamentos'),
('Oficina',              'Espacio de trabajo administrativo'),
('Local comercial',      'Tienda o establecimiento de comercio'),
('Bodega',               'Espacio de almacenamiento');

INSERT INTO element_types (name, description) VALUES
('Muro',     'Elemento vertical que divide o soporta'),
('Columna',  'Elemento vertical que transmite cargas'),
('Viga',     'Elemento horizontal que soporta cargas'),
('Losa',     'Placa horizontal de piso o entrepiso'),
('Puerta',   'Abertura de paso en un muro'),
('Ventana',  'Abertura de luz y ventilación en un muro'),
('Escalera', 'Conexión vertical entre pisos');

INSERT INTO materials (name, description) VALUES
('Concreto reforzado', 'Concreto con acero de refuerzo'),
('Ladrillo',           'Mampostería de arcilla cocida'),
('Acero',              'Perfiles metálicos estructurales'),
('Madera',             'Elementos de madera estructural'),
('Drywall',            'Placas de yeso para divisiones livianas');

INSERT INTO ai_models (name, provider, model_identifier, is_active, is_default) VALUES
('Respuesta de ejemplo', 'mock', 'mock-v1', TRUE, TRUE);