{% macro cdc_latest_record(source_relation, primary_key, timestamp_column='_cdc_timestamp', operation_column='_cdc_operation') %}
    SELECT *
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY {{ primary_key }}
                ORDER BY {{ timestamp_column }} DESC
            ) AS _rn
        FROM {{ source_relation }}
        WHERE {{ operation_column }} != 'DELETE'
    )
    WHERE _rn = 1
{% endmacro %}
