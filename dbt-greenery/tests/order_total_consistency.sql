select *
from {{ source('mart_greenery', 'int_order_promos') }}
where order_total <> (order_cost* (1-(COALESCE(discount,100))/100) + shipping_cost) 