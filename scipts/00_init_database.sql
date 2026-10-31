/*
=============================================================
Database & Data Import
=============================================================
Script Purpose:
    This script creates the database and orders table,
    then imports the FoodHub order dataset into MySQL for analysis.

Steps Performed:
    1. Create the 'food_delivery_platform' database.
    2. Select the database for use.
    3. Create the 'orders' table with the required schema.
    4. Enable local file import.
    5. Load the CSV dataset into the table.

Notes:
    - The dataset is imported using LOAD DATA LOCAL INFILE.
    - Update the file path to match your local machine before executing the script.
    - This script should be executed before running any exploratory or business analysis queries.
*/

-- Create the project database if it does not already exist.
CREATE DATABASE IF NOT EXISTS food_delivery_platform;

-- Select the database for the current session.
USE food_delivery_platform;

-- Create the orders table to store food delivery order data
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_name VARCHAR(100),
    cuisine_type VARCHAR(50),
    cost DECIMAL(10,2),
    day_of_the_week VARCHAR(10),
    rating VARCHAR(10),
    food_preparation_time INT,
    delivery_time INT
);

-- Enable importing data from a local CSV file.
SET GLOBAL local_infile = 1;

-- Import the FoodHub orders dataset into the orders table.
LOAD DATA LOCAL INFILE '/dataset/food_order.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
