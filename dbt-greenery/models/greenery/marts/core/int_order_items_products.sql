{{
  config(
    materialized='table'
  )
}}
select 
a.product_id,
b.name as product_name,
b.price as product_price,
b.quantity as product_quantity,
a.quantity as order_item_quantity,
b.price * a.quantity as order_item_cost
from {{ source('stg_greenery', 'stg_order_items') }} a
INNER JOIN {{ source('stg_greenery', 'stg_products') }} b ON a.product_id = b.product_id