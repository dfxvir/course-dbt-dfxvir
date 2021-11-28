{{
  config(
    materialized='table'
  )
}}

SELECT
a.*
FROM {{ source('greenery', 'products') }} a