-- Case Study #1: Danny's Diner
-- Source: https://8weeksqlchallenge.com/case-study-1/
-- Adapted for Databricks SQL. Run ONE statement at a time (SQLTools sends
-- the whole selection as a single statement). Safe to re-run: each table is replaced.

CREATE SCHEMA IF NOT EXISTS dannys_diner;

CREATE OR REPLACE TABLE dannys_diner.sales (
  customer_id VARCHAR(1),
  order_date  DATE,
  product_id  INTEGER
);

INSERT INTO dannys_diner.sales (customer_id, order_date, product_id) VALUES
  ('A', DATE '2021-01-01', 1),
  ('A', DATE '2021-01-01', 2),
  ('A', DATE '2021-01-07', 2),
  ('A', DATE '2021-01-10', 3),
  ('A', DATE '2021-01-11', 3),
  ('A', DATE '2021-01-11', 3),
  ('B', DATE '2021-01-01', 2),
  ('B', DATE '2021-01-02', 2),
  ('B', DATE '2021-01-04', 1),
  ('B', DATE '2021-01-11', 1),
  ('B', DATE '2021-01-16', 3),
  ('B', DATE '2021-02-01', 3),
  ('C', DATE '2021-01-01', 3),
  ('C', DATE '2021-01-01', 3),
  ('C', DATE '2021-01-07', 3);

CREATE OR REPLACE TABLE dannys_diner.menu (
  product_id   INTEGER,
  product_name VARCHAR(5),
  price        INTEGER
);

INSERT INTO dannys_diner.menu (product_id, product_name, price) VALUES
  (1, 'sushi', 10),
  (2, 'curry', 15),
  (3, 'ramen', 12);

CREATE OR REPLACE TABLE dannys_diner.members (
  customer_id VARCHAR(1),
  join_date   DATE
);

INSERT INTO dannys_diner.members (customer_id, join_date) VALUES
  ('A', DATE '2021-01-07'),
  ('B', DATE '2021-01-09');