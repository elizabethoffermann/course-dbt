Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### Week 1 Project Questions

1. How many users do we have? - We have 130 unique users.

SELECT
COUNT (DISTINCT user_id)
FROM
dbt_elizabeth_o.stg_users



2. On average, how many orders do we receive per hour? - We receive 7.52 orders per hour on average.

--created CTE to truncate the created_at field to just hours

WITH orders_by_hour_cte AS (
        SELECT
        date_trunc('hour', created_at) AS created_at_hour
        , COUNT (DISTINCT order_id) AS order_count
        FROM
        dbt_elizabeth_o.stg_orders
        GROUP BY created_at_hour
        )

SELECT
AVG(order_count)
FROM
orders_by_hour_cte



3. On average, how long does an order take from being placed to being delivered? - On average, it takes 93.4 hours from an order being placed to an order being delivered.

--created CTE to subtract the time between the created_at field and the delivered_at field...had to use EPOCH because of the weird date format

WITH ordered_to_delivery_cte AS (
        SELECT
        EXTRACT (EPOCH FROM delivered_at - created_at)/3600 AS order_to_delivery_hours
        FROM
        dbt_elizabeth_o.stg_orders
        )

SELECT
AVG(order_to_delivery_hours)
FROM
ordered_to_delivery_cte



4. How many users have only made one purchase? Two purchases? Three+ purchases?

Counts_per_user_grouping: only one order
User_count: 25 users

Counts_per_user_grouping: two orders
User_count: 28 users

Counts_per_user_grouping: greater than three orders
User_count: 71 users


--created CTE to figure out orders per user then made orders per user groupings in the outer query

WITH orders_per_user_cte AS (
        SELECT
        user_id
        , COUNT (DISTINCT order_id) AS orders_per_user_count
        FROM
        dbt_elizabeth_o.stg_orders
        GROUP BY user_id
        )

SELECT
CASE 
  WHEN (orders_per_user_count = 1)
  THEN 'only one order'
  WHEN (orders_per_user_count = 2)
  THEN 'two orders'
  ELSE 'greater than three orders'
  END AS counts_per_user_grouping
, COUNT (DISTINCT user_id) AS user_count
FROM
orders_per_user_cte
GROUP BY counts_per_user_grouping



5. On average, how many unique sessions do we have per hour? - We have 16.33 sessions per hour on average.

--created CTE to truncate the created_at field to just hours

WITH unqiue_sessions_per_hour_cte AS (
        SELECT
        date_trunc('hour', created_at) AS created_at_hour
        , COUNT (DISTINCT session_id) AS unique_session_id_count
        FROM
        dbt_elizabeth_o.stg_events
        GROUP BY created_at_hour
        )

SELECT
AVG(unique_session_id_count)
FROM
unqiue_sessions_per_hour_cte