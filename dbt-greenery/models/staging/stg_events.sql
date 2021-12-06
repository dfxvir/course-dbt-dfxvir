{{
  config(
    materialized='table'
  )
}}

SELECT
*,
(case when page_url like 'https://greenary.com/product/%' then {{extract_uuid('page_url')}} END) as product_id,
created_at ::timestamp::date as date_created_at
FROM {{ source('greenery', 'events') }}