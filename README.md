# Taste of the World Café – Menu Performance Analysis

**Tools:** SQL (joins, aggregations, subqueries, CTEs)

**Key Skills Demonstrated:**
- SQL-based exploratory data analysis
- Revenue and item-level performance analysis
- Translating transactional data into business insights
- Data documentation and schema design

---

## Executive Summary

This analysis evaluates the performance of Taste of the World Café’s newly launched menu over its first three months, from **January 1 to March 31, 2023**. Using menu and order-level data, the analysis examines menu composition, ordering patterns, revenue performance, and item-level popularity to establish a baseline for ongoing performance monitoring and decision-making.

During this period, the café recorded **5,370 orders** comprising **12,234 items**, generating **$159,217.90 in total revenue**. Order activity varied by day of the week, with **Mondays exhibiting the highest volume** and **Wednesdays the lowest**, indicating clear demand patterns over time.

Menu performance varied significantly by category. **Italian dishes generated the highest revenue ($49,462.70)** despite not having the highest order volume, while **Asian dishes led in total orders (3,470)** but ranked second in revenue. This divergence highlights differences in pricing and demand across categories.

At the item level, the **Hamburger** and **Edamame** emerged as the most frequently ordered items, while several dishes—including **Chicken Tacos, Veggie Burger, Potstickers, and Cheese Lasagna**—consistently ranked among the least ordered within their respective categories.

Overall, this analysis demonstrates how SQL-based exploration of transactional data can surface actionable insights into customer preferences, revenue drivers, and menu performance.

---

## Business Context

Following the launch of a new menu, Taste of the World Café sought greater visibility into item-level performance and customer ordering behavior. The business required a data-driven understanding of which menu items and categories were driving demand and revenue in order to support future pricing, promotional, and menu optimization decisions.

---

## Database Schema

The analysis is based on two relational tables representing menu offerings and customer orders.

### `menu_items`
| Column Name   | Data Type | Description |
|--------------|-----------|-------------|
| menu_item_id | INT       | Unique identifier for each menu item |
| item_name    | VARCHAR   | Name of the menu item |
| category     | VARCHAR   | Menu category (American, Asian, Mexican, Italian) |
| price        | DECIMAL   | Item price |

### `order_details`
| Column Name       | Data Type | Description |
|------------------|-----------|-------------|
| order_details_id | INT       | Unique identifier for each order line item |
| order_id         | INT       | Identifier for the customer order |
| order_date       | DATE      | Date the order was placed |
| order_time       | TIME      | Time the order was placed |
| item_id          | INT       | Menu item identifier (foreign key to menu_items) |

**Relationship:**  
`order_details.item_id` → `menu_items.menu_item_id` (many-to-one)

---

## Menu Overview

The menu consists of **32 distinct items** across four categories: **American, Asian, Mexican, and Italian**.

Pricing varies across categories:
- **American:** 6 items, average price **$10.07**
- **Asian:** 8 items, average price **$13.48**
- **Mexican:** 9 items, average price **$11.80**
- **Italian:** 9 items, average price **$16.75**

The least expensive item on the menu is *Edamame* at **$5.00**, while the most expensive item is *Shrimp Scampi* at **$19.95**.

---

## Order Activity Overview

The analysis covers a three-month period from **January 1 to March 31, 2023**.

Order volume varies by day of the week, with **Monday showing the highest activity** and **Wednesday the lowest**. During this period:
- **5,370 total orders** were placed
- **12,234 total items** were ordered

---

## Revenue Performance

Total revenue generated during the analysis period was **$159,217.90**.

Revenue and order volume by category:
- **Italian:** $49,462.70 from 2,948 orders
- **Asian:** $46,720.00 from 3,470 orders
- **Mexican:** $34,796.80 from 2,945 orders
- **American:** $28,237.75 from 2,734 orders

While Asian dishes account for the highest number of orders, Italian dishes generate the most revenue overall.

---

## Item Performance & Customer Preferences

Across the entire menu:
- **Most ordered item:** Hamburger (American)
- **Least ordered item:** Chicken Tacos (Mexican)

Within each category:
- **American:** Least ordered – Veggie Burger | Most ordered – Hamburger
- **Asian:** Least ordered – Potstickers | Most ordered – Edamame
- **Italian:** Least ordered – Cheese Lasagna | Most ordered – Spaghetti and Meatballs
- **Mexican:** Least ordered – Chicken Tacos | Most ordered – Steak Torta

These patterns highlight clear customer preferences both across and within menu categories.

---

## Recommendations

- **Focus on High-Performing Categories**  
  Italian and Asian dishes are the primary revenue and volume drivers and should maintain strong visibility and availability.

- **Review Pricing for High-Volume Items**  
  Asian dishes lead in order volume but generate less revenue than Italian dishes, suggesting an opportunity to evaluate pricing for top-performing items.

- **Reassess Underperforming Items**  
  Several items consistently rank lowest in orders within their categories, including Veggie Burger, Potstickers, Cheese Lasagna, and Chicken Tacos.

- **Leverage Customer Favorites**  
  The Hamburger and Edamame are strong customer favorites and may serve as anchor items for promotions or bundled offerings.

- **Align Operations with Demand Patterns**  
  Order volume peaks on Mondays and is lowest on Wednesdays, indicating potential opportunities to align staffing or promotions with demand.

- **Continue Monitoring Performance Over Time**  
  This analysis reflects the first three months following the menu launch. Ongoing monitoring will help validate trends as customer familiarity with the menu increases.


