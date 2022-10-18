{{
  config(
    materialized='view'
  )
}}

WITH order_items_source AS (
  SELECT * FROM {{ source('postgres', 'order_items') }}
)

, renamed_casted AS (
  SELECT
    order_id AS order_items_order_uuid,
    product_id AS order_items_product_uuid,
    quantity AS order_items_quantity
  FROM order_items_source
)


SELECT * FROM renamed_casted