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
a.discount,
a.shipping_cost,
a.order_total,
a.tracking_id,
a.shipping_service,
a.estimated_delivery_at,
a.delivered_at,
a.order_status,
b.product_id,
b.quantity as order_quantity,
c.name as product_name,
c.price as product_price,
c.quantity as product_quantity
from {{ source('mart_greenery', 'int_order_promos') }} a
INNER JOIN {{ source('stg_greenery', 'stg_order_items') }} b ON a.order_id = b.order_id
INNER JOIN {{ source('stg_greenery', 'stg_products') }} c ON b.product_id = c.product_id  