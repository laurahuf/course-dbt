WITH 

product_events AS (

    SELECT * FROM {{ ref('int_product_events') }}
    
),

product_event_totals AS (

    SELECT 
        product_uuid
        , product_name
        , SUM(iff(event_type = 'page_view', 1, 0)) AS total_product_page_views
        , SUM(iff(event_type = 'add_to_cart', 1, 0)) AS total_product_add_to_cart
        , SUM(iff(event_type = 'package_shipped', 1, 0)) AS total_product_package_shipped
        , SUM(iff(event_type = 'checkout', 1, 0)) AS total_product_checkout
    FROM product_events
    GROUP BY 1, 2
),

final AS (

    SELECT
        pe.product_uuid
        , pe.product_name
        , pe.product_price
        , pet.total_product_page_views
        , pet.total_product_add_to_cart
        , pet.total_product_package_shipped
        , pet.total_product_checkout
    
    FROM product_events AS pe
    LEFT JOIN product_event_totals AS pet USING (product_uuid)
)

SELECT * FROM final