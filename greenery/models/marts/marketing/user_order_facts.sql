{{
  config(
    materialized='table'
  )
}}

SELECT
    first_name
    , last_name
    , email
    , phone_number
    , address_id
    , address
    , zipcode
    , state
    , country
    , COUNT(DISTINCT order_id) AS num_of_orders_per_user
    , MIN (order_created_date) AS first_order_date
    , MAX (order_created_date) AS most_recent_order_date
FROM {{ ref('fact_orders') }} orders
GROUP BY 1,2,3,4,5,6,7,8,9