{{ config(materialized='view') }}

select
  BILLING_EVENT_ID as billing_event_id,
  CUSTOMER_ID as customer_id,
  PRODUCT_ID as product_id,
  BILLING_DT as billing_date,
  AMOUNT as amount,
  CURRENCY as currency
from {{ ref('raw_billing_event') }}
