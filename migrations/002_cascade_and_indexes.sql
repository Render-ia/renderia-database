-- Migración 002: al borrar un análisis también se borra su modelo 3D, e índices
-- en las llaves foráneas más consultadas. Es segura de correr varias veces.
-- El backend también la ejecuta al arrancar (SchemaUpdater).
ALTER TABLE models_3d
    DROP CONSTRAINT IF EXISTS models_3d_ai_analysis_id_fkey,
    ADD CONSTRAINT models_3d_ai_analysis_id_fkey
        FOREIGN KEY (ai_analysis_id) REFERENCES ai_analyses(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_projects_user_id ON projects(user_id);
CREATE INDEX IF NOT EXISTS idx_floor_plans_project_id ON floor_plans(project_id);
CREATE INDEX IF NOT EXISTS idx_ai_analyses_floor_plan_id ON ai_analyses(floor_plan_id);
CREATE INDEX IF NOT EXISTS idx_structural_elements_analysis_id ON structural_elements(ai_analysis_id);
CREATE INDEX IF NOT EXISTS idx_models_3d_analysis_id ON models_3d(ai_analysis_id);
CREATE INDEX IF NOT EXISTS idx_activity_logs_user_id ON activity_logs(user_id);
