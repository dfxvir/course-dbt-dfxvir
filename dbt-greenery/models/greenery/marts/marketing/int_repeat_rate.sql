{{
  config(
    materialized='table'
  )
}}
select cast(count(user_id) as decimal)/cast((select count(*) 
from {{ source('stg_greenery', 'stg_users') }}) as decimal) from {{ source('mart_greenery', 'int_repeating_users') }}