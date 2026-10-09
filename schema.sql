-- =========================================
-- Render.IA - Esquema de base de datos
-- =========================================

-- ---------- 1. Autenticación ----------

CREATE TABLE roles (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE users (
    id            BIGSERIAL PRIMARY KEY,
    role_id       BIGINT       NOT NULL REFERENCES roles(id),
    full_name     VARCHAR(120) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_active     BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ---------- 2. Catálogos ----------

CREATE TABLE building_types (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(80)  NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE element_types (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(80)  NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE materials (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(80)  NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE ai_models (
    id               BIGSERIAL PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    provider         VARCHAR(50)  NOT NULL,
    model_identifier VARCHAR(150) NOT NULL UNIQUE,
    is_active        BOOLEAN      NOT NULL DEFAULT TRUE,
    is_default       BOOLEAN      NOT NULL DEFAULT FALSE
);


-- ---------- 3. Negocio ----------

CREATE TABLE projects (
    id               BIGSERIAL PRIMARY KEY,
    user_id          BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    building_type_id BIGINT       REFERENCES building_types(id),
    name             VARCHAR(150) NOT NULL,
    description      TEXT,
    location         VARCHAR(150),
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE floor_plans (
    id          BIGSERIAL PRIMARY KEY,
    project_id  BIGINT       NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    file_name   VARCHAR(255) NOT NULL,
    file_url    VARCHAR(500) NOT NULL,
    floor_level INTEGER      NOT NULL DEFAULT 1,
    scale       VARCHAR(20),
    uploaded_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ai_analyses (
    id            BIGSERIAL PRIMARY KEY,
    floor_plan_id BIGINT      NOT NULL REFERENCES floor_plans(id) ON DELETE CASCADE,
    ai_model_id   BIGINT      NOT NULL REFERENCES ai_models(id),
    status        VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    raw_response  TEXT,
    error_message TEXT,
    duration_ms   INTEGER,
    created_at    TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);