{{
  config(
    materialized='table'
  )
}}
select 
a.order_id,
a.promo_id,
a.user_id,
a.address_id,
a.order_created_at,
a.order_cost,
a.shipping_cost,
a.order_total,
a.tracking_id,
a.shipping_service,
a.estimated_delivery_at,
a.delivered_at,
a.order_status,
b.discount,
b.status as discount_status
from {{ source('stg_greenery', 'stg_orders') }} a
INNER JOIN {{ source('stg_greenery', 'stg_promos') }} b ON a.promo_id = b.promo_id