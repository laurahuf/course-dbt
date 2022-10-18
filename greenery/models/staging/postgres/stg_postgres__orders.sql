{{
  config(
    materialized='view'
    , unique_key = 'order_uuid'
  )
}}

WITH orders_source AS (
  SELECT * FROM {{ source('postgres', 'orders') }}
)

, renamed_casted AS (
  SELECT 
    order_id AS order_uuid,
    promo_id AS order_promo_id,
    user_id AS order_user_uuid,
    address_id AS order_address_uuid,
    created_at AS order_created_at_utc,
    order_cost,
    shipping_cost AS order_shipping_cost,
    order_total AS order_total_cost,
    tracking_id AS order_tracking_uuid,
    shipping_service AS order_shipping_service,
    estimated_delivery_at AS order_estimated_delivery_at_utc,
    delivered_at AS order_delivered_at_utc,
    status AS order_status
  FROM orders_source
)

SELECT * FROM renamed_casted

