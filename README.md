# 🍽️ FoodHub In-App Promotions Analysis | SQL
*Analyzing customer demand, restaurant performance, and cuisine popularity to support data-driven in-app promotion decisions.*

<p align="center">
<img width="450" height="300" alt="project" src="https://github.com/user-attachments/assets/99f3ffd1-1ac6-4fc4-9e71-526cfdd56293" />
</p>

> 📄 **Project at a glance**
>
> Read the **[Executive Summary](docs/Executive_Summary.md)** for a concise overview of the business problem, analysis, key findings, and recommendations.

**Tools:** MySQL 8.0 · SQL (CTEs, Joins, Window Functions, Aggregations, Data Cleaning)

<br>

## 💼 Business Problem
FoodHub is an online food delivery platform that connects customers with restaurants across New York City.

To maximize the impact of in-app promotions, the Growth team wants to identify restaurants and cuisines that consistently demonstrate strong customer demand and positive customer experiences. With a growing number of restaurant partners and orders, it is difficult to decide which restaurants should be prioritized for promotional campaigns.

Without data-driven insights, promotions may target the wrong restaurants, reducing campaign effectiveness and missing opportunities to improve customer engagement, satisfaction, and revenue.

<br>

## 🎯 Objective
This is a portfolio case study. The scenario is simulated: I acted as a data analyst on a Growth Analytics team and analyzed FoodHub's order data to identify high-performing restaurants and cuisines, understand customer demand and repeat behavior, and recommend which partners to promote.

<br>

## 📂 Dataset
The **FoodHub Orders** dataset contains customer food delivery orders placed through an online food delivery platform in New York City.

| Item | Value |
|---|---|
| Orders | 1,898 |
| Customers | 1,200 |
| Restaurants | 178 |
| Cuisines | 14 |
| Day types | Weekday, Weekend |

**Key attributes:** Order ID, Customer ID, Restaurant Name, Cuisine Type, Order Cost, Day of the Week, Customer Rating, Food Preparation Time, Delivery Time.

<br>

## 📁 Repository Structure
```
FoodHub-In-App-Promotions-Analysis
│
├── dataset
│   └── food_order.csv
│
├── sql
│   ├── 00_init_database.sql
│   ├── 01_data_quality_checks.sql
│   ├── 02_data_exploration.sql
│   ├── 03_restaurant_performance_analysis.sql
│   ├── 04_cuisine_performance_analysis.sql
│   └── 05_customer_analysis.sql
│
├── docs
│   └── Executive_Summary.md
│
└── README.md
```

### ▶️ How to Run
1. Install **MySQL 8.0 or later** (CTEs and window functions are required).
2. Open `sql/00_init_database.sql` and update the file path in `LOAD DATA LOCAL INFILE` to match your machine.
3. Run the scripts in order, from `00` to `05`.

<br>

## 📊 Analysis Approach

### 1. 🔍 Exploratory Data Analysis (EDA)
<table>
  <tr>
    <th>Script</th>
    <th>Key Questions</th>
  </tr>
  <tr>
    <td><strong>01 – Data quality checks</strong></td>
    <td>
      <ul>
        <li>Are there any missing or incomplete values?</li>
        <li>Are there duplicate records or duplicate order IDs?</li>
        <li>Are there invalid costs, preparation times, or delivery times?</li>
        <li>How many orders were not rated by customers?</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><strong>02 – Data exploration</strong></td>
    <td>
      <ul>
        <li>What information does the dataset contain?</li>
        <li>How many customers, restaurants, and cuisines are represented?</li>
        <li>What categories and value ranges exist within the dataset?</li>
      </ul>
    </td>
  </tr>
</table>

### 2. 📈 Business Analysis
<table>
  <tr>
    <th>Script</th>
    <th>Key Questions</th>
  </tr>
  <tr>
    <td><strong>03 – Restaurant performance</strong></td>
    <td>
      <ul>
        <li>Which restaurants show strong demand, satisfaction, and revenue potential?</li>
        <li>Which highly rated restaurants with moderate order volumes are strong candidates for targeted promotions?</li>
        <li>Are fulfillment times consistent across restaurants?</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><strong>04 – Cuisine performance</strong></td>
    <td>
      <ul>
        <li>Which cuisines generate the highest demand, satisfaction, and average order value?</li>
        <li>Which highly rated cuisines with moderate order volumes present growth opportunities?</li>
        <li>Do cuisine preferences differ between weekdays and weekends?</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><strong>05 – Customer analysis</strong></td>
    <td>
      <ul>
        <li>How many customers are one-time vs repeat, and how much revenue do they generate?</li>
        <li>Which restaurants have the highest repeat-customer rate?</li>
        <li>Which promotion candidates remain after requiring a minimum number of ratings?</li>
        <li>How do demand and delivery speed differ between weekdays and weekends?</li>
      </ul>
    </td>
  </tr>
</table>

<br>

## 🔍 Key Findings

### 🍽️ Restaurant Performance
* **Shake Shack (219 orders), The Meatball Shop (132), and Blue Ribbon Sushi (119)** had the highest demand, together accounting for **470 orders (24.8% of all orders)**, with average ratings of 4.22–4.51 and average order values of about $16.
* Initial analysis (10–50 orders, 4.5+ rating) flagged 11 restaurants. After requiring **at least 10 ratings**, **4 validated promotion candidates** remain:

| Restaurant | Orders | Ratings | Avg Rating | Repeat-Customer Rate |
|---|---|---|---|---|
| Blue Ribbon Sushi Bar & Grill | 44 | 22 | 4.59 | 48% |
| Five Guys Burgers and Fries | 29 | 18 | 4.56 | 16% |
| Sushi of Gari Tribeca | 24 | 13 | 4.62 | 40% |
| The Kati Roll Company | 16 | 10 | 4.70 | 14% |

* **Blue Ribbon Sushi Bar & Grill** is the strongest candidate: high rating plus the highest repeat-customer rate (48%) among restaurants with 20+ orders.
* Average fulfillment time (preparation + delivery) ranged from about **47 to 54 minutes** across restaurants with more than 10 orders. S'MAC and Sushi Samba were the slowest, so operational capacity is worth checking before promoting them.

### 🍣 Cuisine Performance
* **American (584), Japanese (470), and Italian (298)** were the most-ordered cuisines, together accounting for **1,352 orders (71.2%)**, with ratings of 4.30–4.37 and an average order value of about $16.
* **Indian (4.54★, 73 orders)** is the clearest growth opportunity: strong rating backed by 50 customer ratings.
* **Thai (4.67★)** and **Spanish (4.83★)** are rated highly but have only 9 and 6 ratings, so treat them as promising but unproven.

### 👥 Customer Behavior
* **416 of 1,200 customers (34.7%) ordered more than once**, and they generate **58.7% of orders and 58.6% of revenue**.
* 65% of customers ordered only once, so converting first-time customers into repeat customers is a clear opportunity.

### 📅 Demand Timing
* **Weekends account for 71.2% of orders** (about 675 orders per day vs about 109 on weekdays), and weekend delivery is faster (22.5 vs 28.3 minutes).
* The top cuisines are the same on weekdays and weekends (American, Japanese, Italian), so the cuisine mix does not change, but promotion volume should be weighted toward weekends.

<br>

## 💡 Recommendations
1. **Keep top performers visible.** Maintain high-visibility placement for Shake Shack, The Meatball Shop, and Blue Ribbon Sushi, and for American, Japanese, and Italian cuisines.
2. **Promote the 4 validated restaurants.** Lead with Blue Ribbon Sushi Bar & Grill. For Five Guys and The Kati Roll Company (low repeat rates), use second-order offers to drive repeat visits.
3. **Weight campaigns toward weekends.** Weekends carry most of the demand, so concentrate promotional budget there.
4. **Test Indian cuisine first.** Collect more ratings on Thai and Spanish restaurants before investing in them.
5. **Check capacity before promoting slow restaurants.** Review S'MAC and Sushi Samba fulfillment times first.

<br>

## ⚠️ Limitations
* **38.8% of orders (736) have no rating.** Average ratings come from the rated orders only.
* Several restaurants and cuisines have very few ratings, so a minimum of 10 ratings was used for the final candidate list.
* The dataset has no order dates, so "repeat customer" means 2 or more orders in the dataset and day-level analysis is limited to Weekday/Weekend.
* The dataset covers a single table of orders, with no promotion history, so the impact of past promotions cannot be measured.

<br>

## 🧠 SQL Skills Demonstrated
| Skill | Where Used |
|---|---|
| Data quality checks (nulls, duplicates, invalid values) | `01_data_quality_checks.sql` |
| Aggregations, `GROUP BY`, `HAVING` | `03`, `04`, `05` |
| `CASE`, `CAST` (rating cleaning) | `03`, `04`, `05` |
| Window functions (`RANK`, `DENSE_RANK`) | `04`, `05` |
| CTEs | `05_customer_analysis.sql` |
| Joins | `05_customer_analysis.sql` |

<br>

## 👤 About Me
**Chandan Singh** – aspiring Data Analyst

- 💼 LinkedIn: [linkedin.com/in/chandansingh](https://linkedin.com/in/chandansingh)
- 📧 Email: chandansingh.data@gmail.com
