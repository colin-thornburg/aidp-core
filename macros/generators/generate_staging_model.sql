{% macro generate_staging_model(entity_config) %}
WITH source AS (
    SELECT *
    FROM {{ source(entity_config.source_schema, entity_config.source_table) }}
)
SELECT *
FROM source
{% endmacro %}
