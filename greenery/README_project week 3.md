### Week 3 Project Questions

PART 1

1. What is our overall conversion rate? - we have a 62.46% conversion rate

```sql

-- first a CTE for the number of sessions that turned into check_outs

WITH checked_out_cte AS (
    SELECT COUNT(DISTINCT session_id) AS checked_out_sessions
    FROM dbt_elizabeth_o.fact_page_views
    WHERE event_type LIKE ('checkout')
),

-- then a CTE for the total distinct sessions

all_sessions_cte AS(
    SELECT COUNT(DISTINCT session_id) as total_session_count
    FROM dbt_elizabeth_o.fact_page_views 
)

-- now dividing the two cte results

SELECT 
    ROUND(checked_out_cte.checked_out_sessions / all_sessions_cte.total_session_count :: numeric * 100,2)
FROM checked_out_cte, all_sessions_cte
```


2. What is our conversion rate by product? -- Everything keeps being categorized as NULL here, so I know it is a simple SQL error that I am overlooking. The foundation for the answer is here though :)

```sql

SELECT
  name "Product Name"
, product_id "Product ID"
, ROUND(COUNT(DISTINCT(CASE WHEN event_type LIKE 'checkout' THEN session_id ELSE NULL END)):: numeric/
  COUNT(DISTINCT(session_id)) * 100, 2) "Conversion Rate"
FROM dbt_elizabeth_o.fact_page_views
GROUP BY 1,2
ORDER BY 3 DESC
```

PART 2 
Macro added -> sessions_per_event

PART 3
Macro addd -> grant (for access to models) and I updated the dbt_project.yml file as well. Something in the hook kept erroring out for me and I need to keep noodling on this to fix it.

PART 4
Installed dbt-utils package and dbt_expectations!

PART 5
DAG attached!
