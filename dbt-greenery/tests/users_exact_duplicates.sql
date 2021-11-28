-- Detext exact duplicates in the users table
select first_name, last_name, email, phone_number, count(1)
from {{ source('stg_greenery', 'base_users') }}
group by first_name, last_name, email, phone_number
having count(1) > 1