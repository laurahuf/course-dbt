--dim_products

WITH

products AS (

    SELECT * FROM {{ ref('stg_postgres__products') }}

),

events AS (
    
    SELECT * FROM {{ ref('stg_postgres__events') }}

),

product_events AS (

    SELECT
        p.product_uuid
        , p.product_name
        , p.product_price
        , p.product_inventory
        , e.event_uuid
        , e.event_session_uuid
        , e.event_user_uuid
        , e.event_type
        , e.event_page_url
        , e.event_created_at_utc
        , e.event_order_uuid
        , e.event_product_uuid

    FROM events AS e
    LEFT JOIN products AS p ON e.event_product_uuid = p.product_uuid
    WHERE event_product_uuid IS NOT NULL
),

product_event_totals AS (

    SELECT 
        event_product_uuid
        , product_name
        , SUM(iff(event_type = 'page_view', 1, 0)) AS total_product_page_views
        , SUM(iff(event_type = 'add_to_cart', 1, 0)) AS total_product_add_to_cart
        , SUM(iff(event_type = 'package_shipped', 1, 0)) AS total_product_package_shipped
        , SUM(iff(event_type = 'checkout', 1, 0)) AS total_product_product_checkout
    FROM product_events
    GROUP BY 1, 2
),

final AS (

    SELECT
        p.product_uuid
        , p.product_name
        , p.product_price
        , p.product_inventory
        , pet.total_product_page_views
        , pet.total_product_add_to_cart
        , pet.total_product_package_shipped
        , pet.total_product_product_checkout
    
    FROM products AS p
    LEFT JOIN product_event_totals AS pet ON p.product_uuid = pet.event_product_uuid

)

SELECT * FROM final
