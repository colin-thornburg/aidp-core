{{ config(materialized='view') }}

select
  SUBSCRIBER_ID as subscriber_id,
  CUSTOMER_ID as customer_id,
  PHONE_NUMBER as phone_number,
  STATUS as status
from {{ ref('raw_subscriber') }}
