--int_product_events

WITH

events AS (
    
    SELECT * FROM {{ ref('stg_postgres__events') }}

),

order_items AS (

    SELECT * FROM {{ ref('stg_postgres__order_items') }}

),

products AS (

    SELECT * FROM {{ ref('stg_postgres__products') }}

),

join_events_order_items AS (

    SELECT
       COALESCE(e.event_product_uuid,oi.order_items_product_uuid) AS product_uuid_coalesce
        , oi.order_items_quantity
        , e.event_uuid
        , e.event_session_uuid
        , e.event_user_uuid
        , e.event_type
        , e.event_page_url
        , e.event_created_at_utc
        , oi.order_items_order_uuid

    FROM events AS e
    LEFT JOIN order_items AS oi ON e.event_order_uuid = oi.order_items_order_uuid
),

final AS (

    SELECT *
    
    FROM products AS p

    JOIN join_events_order_items AS eoi ON p.product_uuid = eoi.product_uuid_coalesce

)


SELECT * FROM final
