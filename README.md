# Render.IA — Base de datos

Base de datos de **Render.IA**, una plataforma que usa inteligencia artificial para convertir planos 2D en modelos estructurales 3D.

- **Motor:** PostgreSQL (Neon, región Oregon)
- **Tablas:** 13 (nombres en inglés, datos en español)
- **Integrantes:** Juan David Moreno, Felipe Cerón

## Archivos

| Archivo | Contenido |
|---|---|
| `schema.sql` | Creación de las 12 tablas |
| `seed.sql` | Datos iniciales de roles y catálogos |
| `migrations/` | Cambios aplicados después de la primera versión, en orden |

## Diagrama entidad-relación

```mermaid
erDiagram
    roles ||--o{ users : "tiene"
    users ||--o{ projects : "crea"
    users ||--o{ activity_logs : "registra"
    building_types ||--o{ projects : "clasifica"
    projects ||--o{ floor_plans : "contiene"
    floor_plans ||--o{ ai_analyses : "se analiza en"
    ai_models ||--o{ ai_analyses : "ejecuta"
    ai_analyses ||--o{ structural_elements : "detecta"
    element_types ||--o{ structural_elements : "tipifica"
    materials ||--o{ structural_elements : "compone"
    floor_plans ||--o{ models_3d : "genera"
    ai_analyses ||--o{ models_3d : "origina"
    floor_plans ||--|| floor_plan_files : "guarda la imagen en"

    roles {
        bigint id PK
        varchar name
        varchar description
    }
    users {
        bigint id PK
        bigint role_id FK
        varchar full_name
        varchar email
        varchar password_hash
        boolean is_active
        timestamp created_at
    }
    building_types {
        bigint id PK
        varchar name
        varchar description
    }
    element_types {
        bigint id PK
        varchar name
        varchar description
    }
    materials {
        bigint id PK
        varchar name
        varchar description
    }
    ai_models {
        bigint id PK
        varchar name
        varchar provider
        varchar model_identifier
        boolean is_active
        boolean is_default
    }
    projects {
        bigint id PK
        bigint user_id FK
        bigint building_type_id FK
        varchar name
        text description
        varchar location
        timestamp created_at
        timestamp updated_at
    }
    floor_plans {
        bigint id PK
        bigint project_id FK
        varchar file_name
        varchar file_url
        int floor_level
        varchar scale
        timestamp uploaded_at
    }
    ai_analyses {
        bigint id PK
        bigint floor_plan_id FK
        bigint ai_model_id FK
        varchar status
        text raw_response
        text error_message
        int duration_ms
        timestamp created_at
    }
    structural_elements {
        bigint id PK
        bigint ai_analysis_id FK
        bigint element_type_id FK
        bigint material_id FK
        numeric start_x
        numeric start_y
        numeric end_x
        numeric end_y
        numeric width
        numeric height
        numeric thickness
        numeric confidence
    }
    models_3d {
        bigint id PK
        bigint floor_plan_id FK
        bigint ai_analysis_id FK
        varchar file_url
        varchar format
        int element_count
        timestamp created_at
    }
    floor_plan_files {
        bigint floor_plan_id PK
        varchar content_type
        bytea data
    }
    activity_logs {
        bigint id PK
        bigint user_id FK
        varchar action
        text details
        timestamp created_at
    }
```