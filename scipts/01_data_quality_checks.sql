/*
=============================================================
Data Quality Assessment
=============================================================
Script Purpose:
    This script evaluates the quality of the FoodHub orders
    dataset before performing business analysis.

Questions Answered:
    1. Are there any missing values?
    2. Are there duplicate order IDs?
    3. Are there duplicate order records?
    4. Are there invalid order costs?
    5. Are there invalid preparation or delivery times?
    6. How many orders were not rated?
*/


-- Check for missing values across all columns.
SELECT 
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(restaurant_name IS NULL
        OR TRIM(restaurant_name) = '') AS missing_restaurants,
    SUM(cuisine_type IS NULL
        OR TRIM(cuisine_type) = '') AS missing_cuisine_type,
    SUM(cost IS NULL) AS missing_cost,
    SUM(day_of_the_week IS NULL
        OR TRIM(day_of_the_week) = '') AS missing_days,
    SUM(rating IS NULL OR TRIM(rating) = '') AS missing_rating,
    SUM(food_preparation_time IS NULL) AS missing_food_prep_time,
    SUM(delivery_time IS NULL) AS missing_delivery_time
FROM
    orders;


-- Check for duplicate Order IDs.
SELECT 
    order_id, COUNT(*) AS duplicate_count
FROM
    orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Check for potential duplicate order records based on key order attributes.
SELECT 
    customer_id,
    cuisine_type,
    restaurant_name,
    cost,
    day_of_the_week,
    delivery_time,
    food_preparation_time,
    COUNT(*) AS duplicate_count
FROM
    orders
GROUP BY customer_id , cuisine_type , restaurant_name , cost , day_of_the_week , food_preparation_time , delivery_time
HAVING COUNT(*) > 1;


-- Identify orders with invalid costs.
SELECT 
    order_id, cost
FROM
    orders
WHERE
    cost <= 0;


-- Identify orders with invalid food preparation times.
SELECT 
    order_id, food_preparation_time
FROM
    orders
WHERE
    food_preparation_time <= 0;


-- Identify orders with invalid delivery times.
SELECT 
    order_id, delivery_time
FROM
    orders
WHERE
    delivery_time <= 0;


-- Calculate the number and percentage of orders without customer ratings.
SELECT 
    COUNT(*) AS unrated_orders,
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    orders) * 100),
            2) AS unrated_percent
FROM
    orders
WHERE
    rating = 'Not given';






