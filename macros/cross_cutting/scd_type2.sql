{% macro scd_type2_transform(source_relation, primary_key, tracked_columns, timestamp_column='_transaction_ts') %}
WITH source_data AS (
    SELECT
        *,
        {{ dbt_utils.generate_surrogate_key([primary_key]) }} AS _natural_key,
        {{ dbt_utils.generate_surrogate_key(tracked_columns) }} AS _row_hash
    FROM {{ source_relation }}
)
SELECT * FROM source_data
{% endmacro %}
