{{
  config(
    materialized='view'
  )
}}

WITH users_source AS (
  SELECT * FROM {{ source('postgres','users') }}
)

, renamed_casted AS (
  SELECT
    user_id AS user_uuid,
    first_name AS user_first_name,
    last_name AS user_last_name,
    email AS user_email,
    phone_number AS user_phone_number,
    created_at AS user_created_at_utc,
    updated_at AS user_updated_at_utc,
    address_id AS user_address_uuid
  FROM users_source
)

SELECT * FROM renamed_casted