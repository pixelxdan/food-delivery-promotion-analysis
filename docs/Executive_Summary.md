# 📄 Executive Summary

FoodHub wanted to identify which restaurants and cuisines should be prioritized for in-app promotions to improve customer engagement and maximize promotional effectiveness.

Using **1,898 customer orders** (1,200 customers, 178 restaurants, 14 cuisines), restaurant, cuisine, customer, and ordering-day performance were analyzed in MySQL based on order volume, customer ratings, average order value, repeat behavior, and fulfillment time.

### Key Findings
* **Top-Performing Restaurants**: Shake Shack (11.5%), The Meatball Shop (7.0%), and Blue Ribbon Sushi (6.3%) were the most-ordered restaurants, together accounting for 470 orders (24.8% of all orders) with ratings of 4.22–4.51.
* **Validated Promotion Candidates (Under-Promoted)**: Four restaurants combine a 4.5+ rating with moderate demand (16–44 orders) and at least 10 customer ratings: Blue Ribbon Sushi Bar & Grill (4.59★), Five Guys Burgers and Fries (4.56★), Sushi of Gari Tribeca (4.62★), and The Kati Roll Company (4.70★). Blue Ribbon Sushi Bar & Grill is the strongest, with a 48% repeat-customer rate, the highest among restaurants with 20+ orders.
* **Top-Performing Cuisines**: American, Japanese, and Italian were the most-ordered cuisines, together accounting for 1,352 orders (71.2% of all orders).
* **High-Rated Cuisines (Growth Opportunity)**: Indian (4.54★, 73 orders, 50 ratings) is the clearest opportunity. Thai (4.67★) and Spanish (4.83★) are rated higher but have only 9 and 6 ratings, so they are promising but unproven.
* **Repeat Customers Drive Revenue**: 416 of 1,200 customers (34.7%) ordered more than once and generate 58.7% of orders and 58.6% of revenue. 65.3% of customers ordered only once.
* **Demand Is Concentrated on Weekends**: Weekends account for 71.2% of orders (about 675 orders per day vs about 109 on weekdays). The most popular cuisines are the same on both, so the cuisine mix is stable, but order volume is not.
* **Fulfillment Time Varies Moderately**: Average preparation plus delivery time ranged from about 47 to 54 minutes across restaurants with more than 10 orders. S'MAC and Sushi Samba were the slowest.

### Recommendations
1. **Sustain investment in top performers.** Keep Shake Shack, The Meatball Shop, and Blue Ribbon Sushi, and American, Japanese, and Italian cuisines, in high-visibility placements.
2. **Promote the 4 validated restaurants.** Lead with Blue Ribbon Sushi Bar & Grill. For Five Guys (16% repeat rate) and The Kati Roll Company (14%), use second-order offers to encourage repeat visits.
3. **Weight promotions toward weekends.** Weekends carry most of the demand, so concentrate promotional budget and placements there.
4. **Test Indian cuisine first.** Collect more ratings on Thai and Spanish restaurants before investing in them.
5. **Convert one-time customers.** With 65.3% of customers ordering once, a first-to-second-order incentive is a clear opportunity.
6. **Check capacity before promoting slower restaurants.** Review S'MAC and Sushi Samba fulfillment times first.

### Limitations
* 38.8% of orders (736) have no rating, so average ratings reflect rated orders only.
* Some restaurants and cuisines have very few ratings, so a minimum of 10 ratings was required for the final promotion candidates.
* The dataset has no order dates, so "repeat customer" means 2 or more orders in the dataset, and timing analysis is limited to Weekday vs Weekend.
* There is no promotion history in the data, so the impact of past promotions cannot be measured.
