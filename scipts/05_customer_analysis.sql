/*
=============================================================
Customer & Validated Promotion Analysis
=============================================================
Script Purpose:
    This script analyzes customer ordering behavior and re-validates
    promotion candidates using a minimum number of customer ratings.
    It uses CTEs, joins and window functions to extend the restaurant
    and cuisine analysis in scripts 03 and 04.

Questions Answered:
    1. How many customers are one-time vs repeat customers, and how much
       of the orders and revenue do they generate?
    2. How is the number of orders per customer distributed?
    3. Who are the top 10 customers by total spend?
    4. Which restaurants have the highest share of repeat customers?
    5. Which promotion candidates remain after requiring a minimum
       number of ratings?
    6. How does demand and delivery speed differ between weekdays
       and weekends?

Metrics Used:
    * Orders per Customer
    * Total Customer Spend
    * Repeat Customer Rate
    * Rated Orders (orders with a rating other than 'Not given')
    * Average Customer Rating
    * Orders per Day

Notes:
    * The dataset has a customer_id but no order dates, so repeat
      customer means a customer with 2 or more orders in the dataset.
    * Average ratings exclude orders where the rating is 'Not given'.
    * A minimum of 10 rated orders is required before trusting an average
      rating, because several restaurants and cuisines have very few ratings.
    * The dataset has no dates, so weekday = 5 days and weekend = 2 days
      is assumed when calculating orders per day.
    * Requires MySQL 8.0 or later (CTEs and window functions).
*/


-- 1. Segment customers into one-time and repeat customers and measure
--    their share of total orders and total revenue.
WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        SUM(cost) AS total_spend
    FROM
        orders
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_segment,
    COUNT(*) AS customers,
    SUM(total_orders) AS total_orders,
    ROUND(SUM(total_spend), 2) AS total_revenue,
    ROUND(SUM(total_orders) * 100 / (SELECT COUNT(*) FROM orders), 1) AS pct_of_orders,
    ROUND(SUM(total_spend) * 100 / (SELECT SUM(cost) FROM orders), 1) AS pct_of_revenue
FROM
    customer_summary
GROUP BY customer_segment;


-- 2. Show how many customers placed 1, 2, 3... orders.
WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM
        orders
    GROUP BY customer_id
)
SELECT
    total_orders AS orders_per_customer,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM customer_summary), 1) AS pct_of_customers
FROM
    customer_summary
GROUP BY total_orders
ORDER BY total_orders;


-- 3. Identify the top 10 customers by total spend.
--    DENSE_RANK keeps customers with identical spend at the same rank.
WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        ROUND(SUM(cost), 2) AS total_spend,
        ROUND(AVG(cost), 2) AS avg_order_value
    FROM
        orders
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_orders,
        total_spend,
        avg_order_value,
        DENSE_RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
    FROM
        customer_summary
)
SELECT
    spend_rank,
    customer_id,
    total_orders,
    total_spend,
    avg_order_value
FROM
    ranked_customers
WHERE spend_rank <= 10
ORDER BY spend_rank, customer_id;


-- 4. Rank restaurants by repeat customer rate.
--    Combines customer-level visits with restaurant-level performance using a JOIN.
WITH customer_restaurant AS (
    SELECT
        restaurant_name,
        customer_id,
        COUNT(*) AS visits
    FROM
        orders
    GROUP BY restaurant_name, customer_id
),
restaurant_loyalty AS (
    SELECT
        restaurant_name,
        COUNT(*) AS unique_customers,
        SUM(visits > 1) AS repeat_customers
    FROM
        customer_restaurant
    GROUP BY restaurant_name
),
restaurant_stats AS (
    SELECT
        restaurant_name,
        COUNT(*) AS total_orders,
        COUNT(CASE WHEN rating <> 'Not given' THEN 1 END) AS rated_orders,
        ROUND(AVG(CASE
                    WHEN rating <> 'Not given' THEN CAST(rating AS DECIMAL(2,1))
                END), 2) AS avg_rating
    FROM
        orders
    GROUP BY restaurant_name
)
SELECT
    s.restaurant_name,
    s.total_orders,
    l.unique_customers,
    l.repeat_customers,
    ROUND(l.repeat_customers * 100 / l.unique_customers, 1) AS repeat_rate_pct,
    s.avg_rating,
    s.rated_orders
FROM
    restaurant_stats s
        JOIN
    restaurant_loyalty l ON s.restaurant_name = l.restaurant_name
WHERE s.total_orders >= 20
ORDER BY repeat_rate_pct DESC, s.total_orders DESC
LIMIT 10;


-- 5. Re-validate promotion candidates from script 03 by requiring
--    at least 10 rated orders, and add repeat customer rate for context.
WITH customer_restaurant AS (
    SELECT
        restaurant_name,
        customer_id,
        COUNT(*) AS visits
    FROM
        orders
    GROUP BY restaurant_name, customer_id
),
restaurant_loyalty AS (
    SELECT
        restaurant_name,
        COUNT(*) AS unique_customers,
        SUM(visits > 1) AS repeat_customers
    FROM
        customer_restaurant
    GROUP BY restaurant_name
),
restaurant_stats AS (
    SELECT
        restaurant_name,
        COUNT(*) AS total_orders,
        COUNT(CASE WHEN rating <> 'Not given' THEN 1 END) AS rated_orders,
        ROUND(AVG(CASE
                    WHEN rating <> 'Not given' THEN CAST(rating AS DECIMAL(2,1))
                END), 2) AS avg_rating,
        ROUND(AVG(cost), 2) AS avg_order_value
    FROM
        orders
    GROUP BY restaurant_name
)
SELECT
    s.restaurant_name,
    s.total_orders,
    s.rated_orders,
    s.avg_rating,
    s.avg_order_value,
    ROUND(l.repeat_customers * 100 / l.unique_customers, 1) AS repeat_rate_pct
FROM
    restaurant_stats s
        JOIN
    restaurant_loyalty l ON s.restaurant_name = l.restaurant_name
WHERE s.total_orders BETWEEN 10 AND 50
    AND s.rated_orders >= 10
    AND s.avg_rating >= 4.5
ORDER BY s.avg_rating DESC, s.total_orders DESC;


-- 6. Compare weekday and weekend demand, normalized per day.
--    Weekday = 5 days, weekend = 2 days (assumption: the dataset has no dates).
SELECT
    day_of_the_week,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM orders), 1) AS pct_of_orders,
    ROUND(COUNT(*) / CASE WHEN day_of_the_week = 'Weekday' THEN 5 ELSE 2 END, 1) AS orders_per_day,
    ROUND(AVG(cost), 2) AS avg_order_value,
    ROUND(AVG(food_preparation_time), 2) AS avg_prep_time,
    ROUND(AVG(delivery_time), 2) AS avg_delivery_time
FROM
    orders
GROUP BY day_of_the_week;
