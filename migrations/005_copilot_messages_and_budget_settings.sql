-- Migration 005: the copilot conversation and the budget inputs are saved in the database.
-- Safe to run more than once. The backend also runs it on startup.
CREATE TABLE IF NOT EXISTS copilot_messages (
    id             BIGSERIAL   PRIMARY KEY,
    ai_analysis_id BIGINT      NOT NULL REFERENCES ai_analyses(id) ON DELETE CASCADE,
    user_id        BIGINT      NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role           VARCHAR(10) NOT NULL CHECK (role IN ('user', 'model')),
    content        TEXT        NOT NULL,
    proposals      TEXT,
    created_at     TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_copilot_messages_analysis_user ON copilot_messages(ai_analysis_id, user_id);

CREATE TABLE IF NOT EXISTS budget_settings (
    ai_analysis_id BIGINT    PRIMARY KEY REFERENCES ai_analyses(id) ON DELETE CASCADE,
    inputs         TEXT      NOT NULL,
    updated_by     BIGINT    REFERENCES users(id) ON DELETE SET NULL,
    updated_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
