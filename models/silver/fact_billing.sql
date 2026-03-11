{{ config(materialized='incremental', unique_key='billing_event_id', on_schema_change='append_new_columns') }}


select
  billing_event_id,
  customer_id,
  product_id,
  billing_date,
  amount as billing_amount,
  currency as currency_code
from {{ ref('stg_billing_event') }}
