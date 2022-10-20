--fct_orders.sql

WITH

orders AS (

    SELECT * FROM {{ ref('stg_postgres__orders') }}

),

promos AS (

    SELECT * FROM {{ ref('stg_postgres__promos') }}
),

order_items AS (

    SELECT * FROM {{ ref('stg_postgres__order_items') }}

),

orders_promos__and_order_items_joined AS (

    SELECT
        orders.order_uuid
        , orders.order_created_at_utc
        , orders.order_user_uuid
        , orders.order_promo_id
        , promos.promo_discount
        , promos.promo_status
        , order_items.order_items_quantity
        , orders.order_cost
        , orders.order_shipping_cost
        , orders.order_total_cost
        , orders.order_status
        , orders.order_address_uuid
        , orders.order_shipping_service
        , orders.order_estimated_delivery_at_utc
        , orders.order_delivered_at_utc
        , TIMESTAMPDIFF('hour', orders.order_created_at_utc, orders.order_delivered_at_utc) AS delivery_time_in_hours
        , orders.order_tracking_uuid
    
    FROM orders

    LEFT JOIN promos ON orders.order_promo_id = promos.promo_uuid
    LEFT JOIN order_items ON orders.order_uuid = order_items.order_items_order_uuid

)

SELECT * FROM orders_promos__and_order_items_joined