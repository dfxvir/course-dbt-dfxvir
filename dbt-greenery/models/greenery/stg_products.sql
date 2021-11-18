{{
  config(
    materialized='table'
  )
}}

SELECT
*
FROM {{ source('greenery', 'products') }}