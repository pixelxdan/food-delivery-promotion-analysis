# 🍽️ FoodHub In-App Promotions Analysis| SQL
*Analyzing customer demand, restaurant performance, and cuisine popularity to support data-driven in-app promotion decisions.*

<p align="center">
<img width="450" height="300" alt="project" src="https://github.com/user-attachments/assets/99f3ffd1-1ac6-4fc4-9e71-526cfdd56293" />
</p> 

> 📄 **Project at a glance**
>
> Read the **[Executive Summary](docs/Executive_Summary.md)** for a concise overview of the business problem, analysis, key findings, and recommendations.

<br>

## 💼 Business Problem
FoodHub is an online food delivery platform that connects customers with restaurants across New York City.

To maximize the impact of in-app promotions, the Growth team wants to identify restaurants and cuisines that consistently demonstrate strong customer demand and positive customer experiences. However, with a growing number of restaurant partners and customer orders, it is difficult to determine which restaurants should be prioritized for promotional campaigns.

Without data-driven insights, promotional efforts may target the wrong restaurants, reducing campaign effectiveness and missing opportunities to improve customer engagement, satisfaction, and revenue.

<br>

## 🎯 Objective
As a Data Analyst on the Growth Analytics team, I was tasked with analyzing FoodHub's order data to identify high-performing restaurants and cuisines, understand customer demand, and generate actionable insights to support data-driven in-app promotion decisions.

<br>

## 📂 Dataset
This project uses the **FoodHub Orders** dataset, containing customer food delivery orders placed through an online food delivery platform in New York City.

**Key attributes:** Restaurant Name, Cuisine Type, Order Cost, Day of the Week, Customer Rating, Food Preparation Time, and Delivery Time.

<br>

## 📊 Analysis Approach

1.  ### 🔍Exploratory Data Analysis (EDA)
<table>
  <tr>
    <th>Analysis</th>
    <th>Key Questions</th>
  </tr>

  <tr>
    <td><strong>Data quality checks</strong></td>
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
    <td><strong>Data exploration</strong></td>
    <td>
      <ul>
        <li>What information does the dataset contain?</li>
        <li>How many customers, restaurants, and cuisines are represented?</li>
        <li>What categories and value ranges exist within the dataset?</li>
      </ul>
    </td>
  </tr>
</table>

2. ### 📈 Business Analysis

<table>
  <tr>
    <th>Analysis</th>
    <th>Key Questions</th>
  </tr>

<tr>
    <td><strong>Restaurant Performance Analysis</strong></td>
    <td>
       <ul>
       <li>Which restaurants demonstrate strong customer demand, customer satisfaction, and revenue potential?</li>
       <li> Which highly rated restaurants with moderate order volumes are strong candidates for targeted in-app promotional campaigns?</li>
       <li> Are fulfillment times consistent across restaurants, or are there operational differences to consider?</li>
         </ul>
    </td>
  </tr>
  <tr>
    <td><strong>Cuisine Performance Analysis</strong></td>
    <td>
      <ul>
        <li>Which cuisines generate the highest customer demand, satisfaction, and average order value?</li>
        <li>Which highly rated cuisines with moderate order volumes present growth opportunities?</li>
        <li>Do customer cuisine preferences differ between weekdays and weekends?</li>
      </ul>
    </td>
  </tr>
</table>

   
<br>

## 🔍 Key Findings
1. ### 🍽️ Restaurant Performance Analysis
    *  **Shake Shack (219 orders), The Meatball Shop (132 orders), and Blue Ribbon Sushi (119 orders)** consistently attracted the highest customer demand while maintaining strong average ratings (4.22–4.51) and average order values of approximately $16.
    *  **Blue Ribbon Sushi Bar & Grill, Five Guys Burgers and Fries, Sushi of Gari Tribeca** achieved customer ratings of 4.5+ despite moderate order volumes(24–44 orders), indicating strong potential for targeted promotional campaigns.
    *  Fulfillment times were consistent across restaurants, ranging from approximately 47 to 54 minutes. No significant operational differences were observed among restaurants with more than 10 orders.<br>
      
<br>

2. ### 🍣 Cuisine Performance Analysis
   * **American, Japanese, and Italian** cuisines were the most popular choices among customers, receiving 584, 470, and 298 orders respectively. These cuisines also maintained strong customer ratings (4.30–4.37⭐) with an average order value of around $16.
   * Some cuisines had strong customer satisfaction but lower demand. For example, **Indian (4.54⭐), Thai (4.67⭐), and Spanish (4.83⭐)** cuisines received excellent ratings but had moderate orders(12–73 orders), showing potential opportunities to increase customer awareness.
   * Customer preferences were similar across weekdays and weekends. **American, Japanese, and Italian** cuisines remained the top three choices on both days, suggesting consistent demand throughout the week.
     
<br>
