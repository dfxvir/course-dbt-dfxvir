{{
  config(
    materialized='table'
  )
}}
SELECT
a.user_id, count(*) from {{ source('stg_greenery', 'stg_orders') }} a 
group by a.user_id
having count(*) >= 2
order by count(*) DESC