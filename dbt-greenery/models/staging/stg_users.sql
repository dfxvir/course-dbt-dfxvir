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
b.address_id,
b.address,
b.zipcode,
b.state,
b.country,
a.created_at as user_created_at,
a.updated_at as user_updated_at
FROM {{ source('stg_greenery', 'base_users') }} a LEFT JOIN {{ source('stg_greenery', 'base_addresses') }} b on a.address_id = b.address_id 