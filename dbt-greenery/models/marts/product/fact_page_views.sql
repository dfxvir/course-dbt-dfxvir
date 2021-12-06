{{
  config(
    materialized='table'
  )
}}
SELECT
a.*,
b.*
from {{ source('mart_greenery', 'dim_time') }} b 
inner join {{ source('stg_greenery', 'stg_events') }} a on b.date_actual = a.date_created_at