WEEK 3 PROJECT

PART 1

    What is our overall conversion rate?
        A: 62.46%

            select 
                (total_checkout/total_unique_sessions)*100 AS conversion_rate
            from dev_db.dbt_laurahufnagle.fct_events

    What is our conversion rate by product?

            A: Uploaded screenshot under /greenery/analyses/product_cvr.png
                
            SELECT 
                product_uuid
                , product_name
                , total_product_page_views
                , total_product_checkout
                , round((total_product_checkout/total_product_page_views)*100,2) AS product_conversion_rate
            FROM dev_db.dbt_laurahufnagle.fct_products
            GROUP BY 1,2,3,4
            ORDER BY 5 DESC

        A question to think about: Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 
            -availability, promotion by product,discounts, price, level of care required, seasonality, is a lower rate plant buried in the site/hard to find?

PART 2
    Create a macro to simplify part of a model(s).

        ✅ Complete - created event_type_agg (doesn't work yet tho 😅)

PART 3
    Add a post hook to your project to apply grants to the role “reporting”. 

        ✅ Complete

PART 4
    Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project
    
    Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.

         ✅ Complete - leveraged dbt_utils "get_column_values" for event_type_macro

PART 5
    Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 

    Which orders changed from week 2 to week 3? 

        A: Order_uuid:
            1. 8385cfcd-2b3f-443a-a676-9756f7eb5404
            2. e24985f3-2fb3-456e-a1aa-aaf88f490d70
            3. 5741e351-3124-4de7-9dff-01a448e7dfd4
            4. 914b8929-e04a-40f8-86ee-357f2be3a2a2
            5. 05202733-0e17-4726-97c2-0520c024ab85
            6. 939767ac-357a-4bec-91f8-a7b25edd46c9

        select *
        from dev_db.dbt_laurahufnagle.orders_snapshot
        WHERE dbt_valid_to IS NOT NULL




