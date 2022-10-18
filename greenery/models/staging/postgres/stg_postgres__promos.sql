{{
  config(
    materialized='view'
  )
}}

WITH promos_source AS (
  SELECT * FROM {{ source('postgres','promos') }}
)

, renamed_casted AS (
  SELECT 
    promo_id AS promo_uuid,
    discount AS promo_discount,
    status AS promo_status
  FROM promos_source
)

SELECT * FROM renamed_casted