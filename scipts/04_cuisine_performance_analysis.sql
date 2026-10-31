/*
==================================================================================
Cuisine Analysis
===================================================================================

Script Purpose:
    This script analyzes cuisine-level performance to identify customer preferences,
    growth opportunities, and ordering patterns across different days.

Business Questions Answered:
    1. Which cuisines drive the highest customer demand, satisfaction, and average order value?
    2. Which highly rated cuisines with moderate order volumes represent potential growth opportunities?
    3. Which cuisines are most popular on different days of the week to support campaign timing decisions?

Metrics Used:
    • Total Orders
    • Average Customer Rating
    • Average Order Value
    • Cuisine Ranking by Day

Notes:
    • Average ratings exclude orders where ratings are recorded
      as 'Not given'.
    • Growth opportunity analysis focuses on cuisines with
      moderate order volumes (10–100 orders) and ratings of
      4.5 or higher.
*/


-- Identify cuisines with the highest order volume,customer ratings and average order value.
SELECT 
    cuisine_type,
    COUNT(*) AS total_orders,
    ROUND(AVG(CASE
                WHEN rating <> 'Not given' THEN CAST(rating AS DECIMAL (2 , 1 ))
            END),
            2) AS avg_rating,
    ROUND(AVG(cost), 2) AS avg_order_value
FROM
    orders
GROUP BY cuisine_type
ORDER BY total_orders DESC;

-- Identify cuisines that receive strong ratings but moderate orders
SELECT 
    cuisine_type,
    COUNT(*) AS total_orders,
    ROUND(AVG(CASE
                WHEN rating <> 'Not given' THEN CAST(rating AS DECIMAL (2 , 1 ))
            END),
            2) AS avg_rating,
    ROUND(AVG(cost), 2) AS avg_order_value
FROM
    orders
GROUP BY cuisine_type
HAVING COUNT(*) BETWEEN 10 AND 100
    AND avg_rating >= 4.5
ORDER BY total_orders DESC;

-- Analyze day-level ordering patterns to identify cuisine preferences
SELECT day_of_the_week,
 cuisine_type,COUNT(*) AS total_orders, 
 ROUND(
        AVG(
            CASE
                WHEN rating <> 'Not given'
                THEN CAST(rating AS DECIMAL(2,1))
            END
        ), 2
    ) AS avg_rating,
 RANK() OVER (PARTITION BY day_of_the_week ORDER BY COUNT(order_id) DESC) AS rank_by_day
FROM
    orders
GROUP BY day_of_the_week,cuisine_type;
