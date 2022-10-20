{{
  config(
    materialized='view'
    , unique_key = 'event_uuid'
  )
}}

WITH events_source AS (
  SELECT * FROM {{ source('postgres', 'events') }}
)

, renamed_casted AS (
  SELECT 
    event_id AS event_uuid,
    session_id AS event_session_uuid,
    user_id AS event_user_uuid,
    event_type,
    page_url AS event_page_url,
    created_at AS event_created_at_utc,
    order_id AS event_order_uuid,
    product_id AS event_product_uuid
  FROM events_source
)

SELECT * FROM renamed_casted