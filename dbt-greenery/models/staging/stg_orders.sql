{{
  config(
    materialized='table'
  )
}}

SELECT
a.order_id,
a.promo_id,
a.user_id,
a.address_id,
a.created_at as order_created_at,
a.order_cost,
a.shipping_cost,
a.order_total,
a.tracking_id,
a.shipping_service,
a.estimated_delivery_at,
a.delivered_at,
a.status as order_status
FROM {{ source('greenery', 'orders') }} a