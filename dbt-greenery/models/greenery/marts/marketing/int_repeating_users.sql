{{
  config(
    materialized='table'
  )
}}
SELECT
a.user_id, count(b.order_id) from {{ source('stg_greenery', 'stg_users') }} a 
join {{ source('stg_greenery', 'stg_orders') }} b on a.user_id = b.user_id
group by a.user_id
having count(b.order_id) >= 2
order by count(b.order_id) DESC