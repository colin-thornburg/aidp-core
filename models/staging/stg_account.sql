{{ config(materialized='view') }}

select
  ACCOUNT_ID as account_id,
  ACCOUNT_TYPE as account_type,
  CREDIT_LIMIT as credit_limit
from {{ ref('raw_account') }}
