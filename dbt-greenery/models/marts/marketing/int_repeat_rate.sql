{{
  config(
    materialized='table'
  )
}}
select cast(count(user_id) as decimal)/cast((select count(distinct user_id) 
from {{ source('stg_greenery', 'stg_orders') }}) as decimal) from {{ source('mart_greenery', 'int_repeating_users') }}