Greenery - Week2 Project

#i need to find on tutorial on how to format this file

PART 1 - Models

    What is our user repeat rate?
        A: 79.8%

        Query: (shoutout to Kari Powell, I definitely took this from her code)

        WITH repeat_users AS (
        SELECT
            order_user_uuid
            ,CASE WHEN COUNT(DISTINCT order_uuid) > 1 THEN 1 ELSE 0 END AS repeat_user_uuid_count
            ,CASE WHEN COUNT(DISTINCT order_uuid) > 0 THEN 1 ELSE 0 END AS total_user_uuid_count
        FROM dev_db.dbt_laurahufnagle.stg_postgres__orders
        GROUP BY 1
        )
        SELECT 
            sum(repeat_user_uuid_count)/sum(total_user_uuid_count) AS repeat_rate
        FROM repeat_users


    What are good indicators of a user who will likely purchase again? 
        -ideas   
            -discounts
            -certain product vs another product
            -certain location
            -certain time of year
            -age
            -how long they spend on the site
            -total products ordered
            -frequency (how often does the user come back to our site?)

    What about indicators of users who are likely NOT to purchase again? 
        -ideas
            -inverse of above?
            -order return rate
            -one-time discount users
            -holiday season, gifts purchased once
            -reach a certain max of purchases
        

    If you had more data, what features would you want to look into to answer this question?
        -social media cross-over 
            -do they follow us on X,Y,Z platform? 
            -like/share/save our posts? 
            -what type of posts perform the best?
            -if they follow X account, are they more likely to follow us? 
            -how many of our followers are customers?
        -customer experience ratings
        -how often does the product arrive defective/damaged?
        -number of phone numbers to email addresses; for discounts that are one-time only
        -seasonality of purchases
            -holidays, recessions, pandemics, etc


    mart
    -metrics
        -core:
        #For example, some “core” datasets could include fact_orders, dim_products, and dim_users
            -
        
        -marketing:
        #The marketing mart could contain a model like user_order_facts which contains order information at the user level
            -
        
        -product:
        #The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data
            -

PART 2 - Tests

    We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

        What assumptions are you making about each model? (i.e. why are you adding each test?)
            - i got a little happy with the not_null test. for example, a tracking id can be null if the order is still being prepared

        Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
            - not yet, since i'm so behind on time, i mostly used out of the box tests: unique and not_null

        Apply these changes to your github repo
            -done
    Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
        - implement a script to run these tests behind the scenes and send up flares via a slack alert when tests fail? 

PART 3 - Snapshots

Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 
    SELECT *
    FROM orders_snapshot
    WHERE dbt_valid_to IS NOT NULL

Which orders changed from week 1 to week 2? 
    -submitting this project late, snapshot taken 2022-10-19 03:03:31.863

    I see 6 orders that changed:

        ORDER_ID
            8385cfcd-2b3f-443a-a676-9756f7eb5404
            e24985f3-2fb3-456e-a1aa-aaf88f490d70
            5741e351-3124-4de7-9dff-01a448e7dfd4
            914b8929-e04a-40f8-86ee-357f2be3a2a2
            05202733-0e17-4726-97c2-0520c024ab85
            939767ac-357a-4bec-91f8-a7b25edd46c9