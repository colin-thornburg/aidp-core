{{ config(materialized='view') }}

select
  CUST_ID as customer_id,
  CUST_NM as customer_name,
  EMAIL as email,
  PHONE_NUM as phone_number,
  SSN_NUM as ssn
from {{ ref('raw_customer') }}
