{{
  config(
    materialized='view'
  )
}}

WITH products_source AS (
  SELECT * FROM {{ source('postgres','products')}}
)

, renamed_casted AS (
  SELECT 
      product_id AS product_uuid,
      name AS product_name,
      price AS product_price,
      inventory AS product_inventory
  FROM products_source
)

SELECT * FROM renamed_casted