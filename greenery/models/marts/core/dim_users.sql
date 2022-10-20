--dim_users.sql
WITH 

users AS (

  SELECT * FROM {{ ref('stg_postgres__users' ) }}

),

addresses AS (

  SELECT * FROM {{ ref('stg_postgres__addresses' ) }}

),

users_and_addresses_joined AS (

  SELECT
  users.user_uuid
  , users.user_email
  , users.user_first_name
  , users.user_last_name
  , users.user_phone_number
  , users.user_created_at_utc
  , users.user_updated_at_utc
  , addresses.address_uuid
  , addresses.address_street_address
  , addresses.address_zipcode
  , addresses.address_state

  FROM users

  LEFT JOIN addresses ON users.user_address_uuid = addresses.address_uuid

)

SELECT * FROM users_and_addresses_joined
