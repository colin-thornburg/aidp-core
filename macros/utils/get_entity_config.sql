{% macro get_entity_config(entity_name) %}
  {{ return(load_yaml('models/_entity_configs/' ~ entity_name ~ '.yml')) }}
{% endmacro %}
