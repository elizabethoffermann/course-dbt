Part 1. dbt Snapshots

I made an orders snapshot and put it in the snapshot folder - yes, I did see a change! 

```sql

{% snapshot orders %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='timestamp',
      updated_at='estimated_delivery_at',
    )
  }}

  SELECT
    *
  FROM
    {{ source('pg', 'orders') }}

{% endsnapshot %}
```

Part 2. Modeling challenge

How are our users moving through the product funnel? / Which steps in the funnel have largest drop off points?

I created a three part CTE and unioned them all at the end to see how the funnel moved from # sessions with page views, # of add-to-carts, to # of checkouts. The biggest dip is the ~80% of sessions with page views who add a product in the cart, but a little over half of those actually click purchase.

Greenery needs to figure out how to get about half of their site visitors to actually check out. I have seen this happen before as a customer where I leave something in my virtual cart and then I get an email with a reminder to purchase or an email with a free shipping/discount code for my chart items. This might be the exact tactic to fill the gap for greenery!

Exposure - I was so close to being able to set up the exposure for my models, but since I did not create a separate model for my funnel, I paused, stopped troubleshooting, deleted the yml file, and decided to just absorb the directions about how to create an exposure and why we might want to create an exposure. I did have an exposures.yml file at minimum in the models - marts - product folder.


3a. If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

- I am not sure if we use exposures on our final analytics model, but this seems like a nice way to flag essentially "certified" models.

- I also see the value in more tests on our data to ensure high data integrity and data quality along with potentially more macros to sift through the huge amount of data we have as a company.





