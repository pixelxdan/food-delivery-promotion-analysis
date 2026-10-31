/*
=============================================================
Data Exploration
=============================================================
Script Purpose:
    This script performs an initial exploration of the
    FoodHub orders dataset to understand its structure,
    size, and key characteristics before assessing data
    quality or performing business analysis.

Questions Answered:
   1. How many records are in the dataset?
    2. What columns and data types are available?
    3. What does the dataset look like?
    4. How many unique customers, restaurants, and cuisines are represented?
    5. What categorical values exist?
    6. What is the range of numeric values?
*/

--Displays total orders
SELECT 
    COUNT(*) AS total_orders
FROM
    orders;

-- Displays the table structure, including column names,
-- data types, and constraints.
DESCRIBE orders;

-- Displays the first five records to understand the dataset contents
SELECT 
    *
FROM
    orders
LIMIT 5;

-- Display the total number of unique customers, restaurants,
-- and cuisine types.
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT restaurant_name) AS total_restaurants,
    COUNT(DISTINCT cuisine_type) AS total_cuisines
FROM
    orders;

-- Display the unique values for the day of the week.
SELECT DISTINCT
    day_of_the_week AS unique_days
FROM
    orders;

-- Display the unique customer rating values.
SELECT DISTINCT
    rating AS unique_rating
FROM
    orders;

-- Summarize the order cost distribution.
SELECT 
    MIN(cost) AS minimum_cost,
    MAX(cost) AS maximum_cost,
    ROUND(AVG(cost), 2) AS avg_cost
FROM
    orders;

-- Summarize order fulfillment times.
-- Calculate the minimum, maximum, and average time taken
-- from food preparation through delivery.
SELECT
    MIN(food_preparation_time + delivery_time) AS minimum_fulfillment_time,
    MAX(food_preparation_time + delivery_time) AS maximum_fulfillment_time,
    ROUND(AVG(food_preparation_time + delivery_time), 2) AS avg_fulfillment_time
FROM orders;
