{{
  config(
    materialized='table'
  )
}}

SELECT
*,
trim('https://greenary.com/product/' from page_url) as product_id,
created_at ::timestamp::date as date_created_at
FROM {{ source('greenery', 'events') }}