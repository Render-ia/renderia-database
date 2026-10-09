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