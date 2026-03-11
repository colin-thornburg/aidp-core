{% macro generate_silver_model(entity_config) %}
WITH base AS (
    SELECT * FROM {{ ref(entity_config.staging_model) }}
)
SELECT * FROM base
{% endmacro %}
