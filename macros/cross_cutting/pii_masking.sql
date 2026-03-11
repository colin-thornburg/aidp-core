{% macro pii_hash(column_name, algorithm='sha256') %}
    {% if algorithm == 'md5' %}
    MD5(CAST({{ column_name }} AS STRING))
    {% else %}
    SHA2(CAST({{ column_name }} AS STRING), 256)
    {% endif %}
{% endmacro %}

{% macro pii_mask(column_name, mask_type='full') %}
    {% if mask_type == 'email' %}
    CONCAT(LEFT({{ column_name }}, 2), '***@', SPLIT_PART({{ column_name }}, '@', 2))
    {% elif mask_type == 'phone' %}
    CONCAT('***-***-', RIGHT({{ column_name }}, 4))
    {% else %}
    '**MASKED**'
    {% endif %}
{% endmacro %}

{% macro apply_pii_policy(pii_columns) %}
    {% for col in pii_columns %}
        {% if col.handling == 'hash' %}
    , {{ pii_hash(col.column) }} AS {{ col.column }}_hashed
        {% elif col.handling == 'mask' %}
    , {{ pii_mask(col.column, col.mask_type | default('full')) }} AS {{ col.column }}_masked
        {% elif col.handling == 'redact' %}
    , NULL AS {{ col.column }}
        {% endif %}
    {% endfor %}
{% endmacro %}
