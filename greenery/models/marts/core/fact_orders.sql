{{
  config(
    materialized='table'
  )
}}

SELECT
    orders.order_id
    , orders.user_id
    , orders.promo_id
    , orders.address_id
    , orders.created_at AS order_created_date
    , orders.order_cost
    , orders.shipping_cost
    , orders.order_total
    , orders.estimated_delivery_at
    , orders.delivered_at
    , orders.status
    , dim_users.first_name
    , dim_users.last_name
    , dim_users.email
    , dim_users.phone_number
    , dim_users.address
    , dim_users.zipcode
    , dim_users.state
    , dim_users.country
FROM {{ ref('stg_orders') }} orders
LEFT JOIN {{ ref('dim_users') }} dim_users ON orders.user_id = dim_users.user_id