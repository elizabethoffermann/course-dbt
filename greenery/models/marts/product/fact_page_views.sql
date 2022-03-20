{{
  config(
    materialized='table'
  )
}}

SELECT
    events.event_id
    , events.session_id
    , events.user_id
    , events.page_url
    , events.product_id
    , products.name
    , products.price
    , products.inventory
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.address_id
    , users.address
    , users.zipcode
    , users.state
    , users.country
FROM {{ ref('stg_events') }} events
INNER JOIN {{ ref('dim_users') }} users
    ON events.user_id = users.user_id
INNER JOIN {{ ref('stg_products') }} products
    ON events.product_id = products.product_id