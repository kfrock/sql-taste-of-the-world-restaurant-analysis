/* 
Author: Kimberly Frock

Business problem: 
Following the launch of a new menu, The Taste of the World Café lacks visibility into item-level performance. 
The business needs to identify top-performing and underperforming menu items, as well as customer favorites, 
in order to make data-driven decisions around menu optimization, pricing, and promotions.
*/
USE restaurant_db;

/* Objective One: Explore items in table */

-- 1. View the menu_items table
SELECT *
FROM menu_items;

-- 2. How many distinct menu items are there?
SELECT 
	COUNT(DISTINCT item_name) AS number_of_items_on_menu
FROM menu_items;

-- 3. What are the least/most expensive dishes on the menu?

SELECT 
	'Least expensive' AS category,
    item_name AS dish,
    price
FROM menu_items
    WHERE price = (SELECT MIN(price) FROM menu_items)
    
UNION ALL

SELECT 
	'Most Expensive' AS category,
    item_name AS dish,
    price
FROM menu_items
WHERE price = (SELECT MAX(price) FROM menu_items)
;


-- 4. How many italian dishes are on the menu?
SELECT
	COUNT(category) AS number_of_italian_dishes
FROM menu_items
WHERE category = "Italian"
;

-- 5. What are the least/most expensive italian dishes  on the menu?
SELECT 
	'Least expensive Italian' AS category,
    item_name AS dish,
    price
FROM menu_items
    WHERE price = (
		SELECT 
			MIN(price) 
            FROM menu_items
            WHERE category = 'Italian') AND
			category = 'Italian'
    
UNION ALL

SELECT 
	'Most Expensive Italian' AS category,
    item_name AS dish,
    price
FROM menu_items
WHERE price = (SELECT 
				MAX(price) 
                FROM menu_items
                WHERE category = 'Italian') AND
			category = 'Italian'
;

-- 6. How many dishes are in each category and what is the average dish price in each category

SELECT 
	category,
	COUNT(*) AS category_count,
    ROUND(AVG(price),2) AS average_dish_price
FROM menu_items
GROUP BY
	category
ORDER BY average_dish_price DESC;

/* Objective Two: Explore orders table */

SELECT *
FROM order_details;

-- 1. What is the date range of the table?
SELECT
	MIN(order_date) AS oldest_date,
    MAX(order_date) AS most_recent_date
FROM order_details;

-- 1.a What day of the week has the most orders?
SELECT
	DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS total_orders
FROM order_details
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC

-- 2. How many orders were made within this date range? How many items were ordered within this date range?
SELECT
	COUNT(DISTINCT order_id) AS order_count,
    COUNT(order_id) AS items_ordered
FROM order_details;


-- 3. Which orders had the most number of items?
SELECT
	order_id,
    COUNT(order_id) AS ordered_items
FROM order_details
GROUP BY 
	order_id
ORDER BY ordered_items DESC;

-- 4. How many orders had more than 12 items?
SELECT
	COUNT(*) AS orders_over_12_items
    FROM (
		SELECT 
			order_id,
			COUNT(item_id) AS num_items
        FROM order_details
        GROUP BY order_id
        HAVING COUNT(*) > 12
        ) AS sub;


/* Objective Three: Analyze customer behavior */
-- 1. combine menu_items and order_details into a single table
SELECT *
FROM menu_items
LEFT JOIN order_details
	ON menu_items.menu_item_id = order_details.item_id

-- 2. What were the least/most ordered items? What categories are they in?
(SELECT
	'Least Ordered' AS popularity,
	m.category,
	m.item_name,
	COUNT(o.item_id) AS order_count  
FROM menu_items m
	LEFT JOIN order_details o
		ON m.menu_item_id = o.item_id 
        
GROUP BY
	m.menu_item_id,
	m.item_name,
    m.category
ORDER BY 
	order_count 
LIMIT 1
)
UNION ALL
(
SELECT
	'Most Ordered' AS popularity,
	m.category,
	m.item_name,
	COUNT(o.item_id) AS order_count   
FROM menu_items m
	LEFT JOIN order_details o
		ON m.menu_item_id = o.item_id 
GROUP BY
	m.menu_item_id,
	m.item_name,
    m.category
ORDER BY 
	order_count DESC
LIMIT 1
);


-- 3. What were the top 5 orders that spent the most money?
SELECT
	o.order_id,
    SUM(m.price) AS order_cost
FROM order_details o
	INNER JOIN menu_items m
		ON o.item_id = m.menu_item_id
GROUP BY
	o.order_id
ORDER BY 
	order_cost DESC,
    o.order_id
LIMIT 5;

-- 4. What items were purchased in the highest spend order?
SELECT
	m.item_name
FROM order_details o
	LEFT JOIN menu_items m 
		ON o.item_id = m.menu_item_id
WHERE order_id = 440

-- 5. What are the details of the top 5 highest spend orders?
SELECT
    o.order_id,
    m.item_name,
    m.price,
    t.item_count,
    t.order_total
FROM order_details o
JOIN menu_items m
  ON o.item_id = m.menu_item_id
JOIN (
    SELECT
        o2.order_id,
        COUNT(*) AS item_count,
        SUM(m2.price) AS order_total
    FROM order_details o2
    JOIN menu_items m2
      ON o2.item_id = m2.menu_item_id
    GROUP BY o2.order_id
    ORDER BY order_total DESC
    LIMIT 5
) t
  ON o.order_id = t.order_id
ORDER BY
    t.order_total DESC,
    o.order_id,
    m.item_name;





