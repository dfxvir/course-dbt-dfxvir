{{
  config(
    materialized='table'
  )
}}
SELECT
a.user_id,
a.first_name,
a.last_name,
a.email,
a.phone_number,
a.address_id,
a.address,
a.zipcode,
a.state,
a.country,
a.user_created_at,
a.user_updated_at,
b.order_id,
b.address_id as order_address_id,
b.order_created_at,
b.order_cost,
b.shipping_cost,
b.order_total,
b.tracking_id,
b.shipping_service,
b.estimated_delivery_at,
b.delivered_at,
b.order_status,
b.promo_id,
b.discount,
b.discount_status
from {{ source('mart_greenery', 'dim_users') }} a 
inner join {{ source('mart_greenery', 'int_order_promos') }} b on a.user_id = b.user_id