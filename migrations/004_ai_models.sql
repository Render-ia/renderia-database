-- Migration 004: the local vision detector and the detector checked by Gemini.
-- Safe to run more than once. The backend also runs it on startup.
-- 'gemini:flash' follows GEMINI_MODEL in the AI service, so the Gemini model
-- changes without touching the database. Without GEMINI_API_KEY it falls back
-- to the vision detector alone.
INSERT INTO ai_models (name, provider, model_identifier, is_active, is_default) VALUES
    ('Detector de visión local',    'local-vision', 'renderia-vision-v1', TRUE, FALSE),
    ('Detector de visión + Gemini', 'gemini',       'gemini:flash',       TRUE, FALSE)
ON CONFLICT (model_identifier) DO NOTHING;
