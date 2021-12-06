{{
  config(
    materialized='table'
  )
}}

SELECT
*
FROM {{ source('greenery', 'order_items') }}