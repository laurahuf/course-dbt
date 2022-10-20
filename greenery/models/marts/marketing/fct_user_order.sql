{{
    config(
      materialized='table'
    )

}}

WITH

users AS (

SELECT * FROM {{ ref('dim_users') }}

),

orders AS (

  SELECT * FROM {{ ref('fct_orders') }}

),

user_order_stats AS (

  SELECT 
    orders.order_user_uuid
    , DATE_TRUNC('DAY', MIN(orders.order_created_at_utc)) AS first_order_date
    , DATE_TRUNC('DAY', MAX(orders.order_created_at_utc)) AS last_order_date
    , COUNT(DISTINCT orders.order_uuid) AS total_user_orders
    , SUM(orders.order_total_cost) AS user_lifetime_value
  
  FROM orders

  GROUP BY 1
),

final AS (

  SELECT *
  FROM users u
  LEFT JOIN user_order_stats uos ON u.user_uuid = uos.order_user_uuid

)