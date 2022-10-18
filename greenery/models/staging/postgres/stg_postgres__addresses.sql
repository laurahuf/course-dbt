{{
  config(
    materialized='view'
    , unique_key = 'address_uuid'
  )
}}

WITH address_source AS (
  SELECT * FROM {{ source('postgres', 'addresses') }}
)

, renamed_casted AS (
  SELECT 
    address_id AS address_uuid,
    address AS address_street_address,
    zipcode AS address_zipcode,
    state AS address_state,
    country AS address_country
  FROM address_source
)

SELECT * FROM renamed_casted