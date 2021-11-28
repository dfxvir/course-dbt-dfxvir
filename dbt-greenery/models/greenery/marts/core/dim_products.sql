{{
  config(
    materialized='table'
  )
}}
select *
from {{ source('stg_greenery', 'stg_products') }}