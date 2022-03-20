{{
  config(
    materialized='table'
  )
}}

SELECT
  users.user_id
  , users.email
  , users.first_name
  , users.last_name
  , users. address_id
  , users.phone_number
  , addres.address
  , addres.zipcode
  , addres.state
  , addres.country
FROM {{ ref('stg_users') }} users
LEFT JOIN {{ ref('stg_addresses') }} addres ON users.address_id = addres.address_id
