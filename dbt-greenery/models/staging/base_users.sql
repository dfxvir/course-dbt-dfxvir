{{
  config(
    materialized='table'
  )
}}

SELECT
*
FROM {{ source('greenery', 'users') }}