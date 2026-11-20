-- Migration 003: Reviewer and Client roles, and projects shared with other users.
-- Safe to run more than once. The backend also runs it on startup.
INSERT INTO roles (name, description) VALUES
    ('Revisor', 'Revisa y valida los proyectos de todos, sin borrar'),
    ('Cliente', 'Ve los proyectos que le comparten, en modo cliente')
ON CONFLICT (name) DO NOTHING;

CREATE TABLE IF NOT EXISTS project_members (
    id         BIGSERIAL PRIMARY KEY,
    project_id BIGINT    NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id    BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (project_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_project_members_user_id ON project_members(user_id);
