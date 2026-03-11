{{ config(materialized='table') }}

with base as (
  select * from {{ ref('stg_customer') }}
),
acct as (
  select * from {{ ref('stg_account') }}
)
select
  base.customer_id,
  base.customer_name,
  acct.account_type,
  {{ control_fields() }}
  {{ apply_pii_policy([
    {"column": "email", "handling": "mask", "mask_type": "email"},
    {"column": "phone_number", "handling": "mask", "mask_type": "phone"},
    {"column": "ssn", "handling": "hash"}
  ]) }}
from base
left join acct on base.customer_id = acct.account_id
