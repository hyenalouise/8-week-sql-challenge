-- Case Study #1: Danny's Diner: Solutions
-- Run schema.sql first.
-- Full question wording: https://8weeksqlchallenge.com/case-study-1/

-- ------------------------------------------------------------
-- Q1. What is the total amount each customer spent at the restaurant?
-- ------------------------------------------------------------
-- exploratory queries
SELECT * FROM dannys_diner.sales;
SELECT * FROM dannys_diner.menu;

SELECT 
    s.customer_id,
    m.product_name,
    m.price
FROM
    dannys_diner.sales s
    LEFT JOIN dannys_diner.menu m 
    ON s.product_id = m.product_id;

-- final query
SELECT 
    s.customer_id,                          -- one row per customer
    SUM(m.price) AS total_spent             -- total amount spent by customer
FROM
    dannys_diner.sales s
    LEFT JOIN dannys_diner.menu m 
    ON s.product_id = m.product_id
GROUP BY s.customer_id                      -- group by customer_id to get one row per customer
ORDER BY s.customer_id;                     -- for sorting purposes

-- ------------------------------------------------------------
-- Q2. How many days has each customer visited the restaurant?
-- ------------------------------------------------------------
-- exploratory queries
SELECT * FROM dannys_diner.sales;
SELECT * FROM dannys_diner.members;

-- final query
SELECT 
    s.customer_id,
    COUNT(DISTINCT s.order_date) AS days_visited
FROM
    dannys_diner.sales s
GROUP BY s.customer_id;

-- ------------------------------------------------------------
-- Q3. What was the first item from the menu purchased by each customer?
-- ------------------------------------------------------------
-- exploratory queries
SELECT * FROM dannys_diner.sales;
SELECT * FROM dannys_diner.menu;
SELECT 
    s.customer_id,                              -- one row per customer
    m.product_name,                             -- product_name of the first item purchased by customer
    MIN(s.order_date) AS first_order_date       -- first order date for each customer 
FROM
    dannys_diner.sales s                        -- one row per sale
    LEFT JOIN dannys_diner.menu m               -- one row per menu item
    ON s.product_id = m.product_id              -- join sales to menu to get product_name and price
GROUP BY 
    s.customer_id, 
    m.product_name, 
    s.order_date;                               -- group by customer_id, product_name, and order_date to get one row per customer and product
    
-- final query
SELECT 
    s.customer_id,                              -- one row per customer
    m.product_name,                             -- product_name of the first item purchased by customer
    s.order_date,                               -- first order date for each customer
    DENSE_RANK() OVER 
        (PARTITION BY s.customer_id 
        ORDER BY s.order_date) 
            AS first_order_rank    
FROM
    dannys_diner.sales s                        -- one row per sale
    LEFT JOIN dannys_diner.menu m               -- one row per menu item
    ON s.product_id = m.product_id              -- join sales to menu to get product_name      


-- final query with CTE
WITH ranked AS (
  SELECT 
    s.customer_id,                              -- one row per customer
    m.product_name,                             -- product_name of the first item purchased by customer
    s.order_date,                               -- first order date for each customer
    DENSE_RANK() OVER 
        (PARTITION BY s.customer_id 
        ORDER BY s.order_date) 
            AS first_order_rank    
FROM
    dannys_diner.sales s                        -- one row per sale
    LEFT JOIN dannys_diner.menu m               -- one row per menu item
    ON s.product_id = m.product_id              -- join sales to menu to get product_name      
)
SELECT 
    customer_id,
    product_name,
    order_date
FROM ranked
WHERE first_order_rank = 1;

-- ------------------------------------------------------------
-- Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- ------------------------------------------------------------
-- exploratory queries
SELECT * FROM dannys_diner.sales;
SELECT * FROM dannys_diner.menu;

-- final query
SELECT 
    m.product_name,                             -- product_name of the most purchased item
    COUNT(s.product_id) AS times_purchased      -- number of times the most purchased item
FROM
    dannys_diner.sales s                        -- one row per sale
    LEFT JOIN dannys_diner.menu m               -- one row per menu item
    ON s.product_id = m.product_id              -- join sales to menu to get product_name
GROUP BY m.product_name                         -- group by product_name to get one row per product
ORDER BY times_purchased DESC                   -- order by times purchased in descending order 
LIMIT 1;

-- ------------------------------------------------------------
-- Q5.
-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- Q6.
-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- Q7.
-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- Q8.
-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- Q9.
-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- Q10.
-- ------------------------------------------------------------


-- ============================================================
-- Bonus: Join All The Things
-- ============================================================


-- ============================================================
-- Bonus: Rank All The Things
-- ============================================================

