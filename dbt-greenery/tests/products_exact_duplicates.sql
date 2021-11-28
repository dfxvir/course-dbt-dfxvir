-- Detext exact duplicates in the products table
select name, count(1)
from {{ source('stg_greenery', 'stg_products') }}
group by name
having count(1) > 1