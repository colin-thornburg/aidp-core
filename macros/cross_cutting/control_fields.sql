{% macro control_fields(source_type='batch', include_batch_id=true, include_lineage=true) %}
    CURRENT_TIMESTAMP() AS _ingestion_ts
    {% if include_batch_id %}
    , '{{ invocation_id }}' AS _batch_id
    {% endif %}
    {% if source_type == 'cdc' %}
    , _cdc_operation AS _operation_type
    , _cdc_timestamp AS _transaction_ts
    , _cdc_sequence AS _sequence_id
    {% else %}
    , CURRENT_TIMESTAMP() AS _transaction_ts
    , NULL AS _sequence_id
    , 'BATCH_LOAD' AS _operation_type
    {% endif %}
    {% if include_lineage %}
    , '{{ this.schema }}' AS _source_schema
    , '{{ this.name }}' AS _source_model
    , '{{ run_started_at }}' AS _dbt_run_started_at
    {% endif %}
{% endmacro %}
