-- Create a new database for DMart project
CREATE DATABASE dmart_db;

-- Use the DMart database
USE dmart_db;

-- Stores all product information
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    stock_qty INT NOT NULL
);

-- Stores customer details
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL
);

-- Stores every sales transaction
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    -- Create relationship between tables
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert product data
INSERT INTO products VALUES
(1,'Rice','Grocery',60,300),
(2,'Wheat Flour','Grocery',45,250),
(3,'Milk','Dairy',30,200),
(4,'Curd','Dairy',35,180),
(5,'Bread','Bakery',40,150),
(6,'Biscuits','Snacks',20,400),
(7,'Cooking Oil','Grocery',120,120),
(8,'Sugar','Grocery',50,220),
(9,'Soap','Personal Care',25,350),
(10,'Shampoo','Personal Care',95,140),
(11,'Tea Powder','Beverages',110,160),
(12,'Cold Drink','Beverages',40,300);

-- Insert customer data
INSERT INTO customers VALUES
(1,'Amit','Mumbai'),
(2,'Sneha','Thane'),
(3,'Rahul','Pune'),
(4,'Neha','Mumbai'),
(5,'Rohit','Nashik'),
(6,'Priya','Thane'),
(7,'Karan','Mumbai'),
(8,'Pooja','Pune'),
(9,'Vikas','Mumbai'),
(10,'Anjali','Thane');

-- Insert sales transactions
INSERT INTO sales VALUES
(1,1,1,5,'2025-01-01',300),
(2,2,3,4,'2025-01-01',120),
(3,3,6,10,'2025-01-02',200),
(4,4,5,2,'2025-01-02',80),
(5,5,7,1,'2025-01-03',120),
(6,6,2,3,'2025-01-03',135),
(7,7,9,6,'2025-01-04',150),
(8,8,12,5,'2025-01-04',200),
(9,9,1,4,'2025-01-05',240),
(10,10,8,3,'2025-01-05',150),

(11,1,11,2,'2025-01-06',220),
(12,2,10,1,'2025-01-06',95),
(13,3,4,3,'2025-01-07',105),
(14,4,6,8,'2025-01-07',160),
(15,5,5,2,'2025-01-08',80),

(16,6,3,5,'2025-01-08',150),
(17,7,7,1,'2025-01-09',120),
(18,8,9,4,'2025-01-09',100),
(19,9,12,6,'2025-01-10',240),
(20,10,2,2,'2025-01-10',90),

(21,1,8,3,'2025-01-11',150),
(22,2,1,5,'2025-01-11',300),
(23,3,11,1,'2025-01-12',110),
(24,4,10,2,'2025-01-12',190),
(25,5,6,6,'2025-01-12',120);

-- Show all tables in database
SHOW TABLES;

-- View all products
SELECT * FROM products;

-- View all customers
SELECT * FROM customers;

-- View all sales transactions
SELECT * FROM sales;

-- Show only grocery products
SELECT * FROM products
WHERE category = 'Grocery';

-- Sales above 200 amount
SELECT * FROM sales
WHERE total_amount > 200;

-- Highest bill first
SELECT * FROM sales
ORDER BY total_amount DESC;

-- Top 5 highest sales
SELECT * FROM sales
ORDER BY total_amount DESC
LIMIT 5;

-- Total revenue
SELECT SUM(total_amount) FROM sales;

-- Number of sales
SELECT COUNT(*) FROM sales;

-- Average bill value
SELECT AVG(total_amount) FROM sales;

-- Revenue per day
SELECT sale_date, SUM(total_amount)
FROM sales
GROUP BY sale_date;

-- Revenue per customer
SELECT customer_id, SUM(total_amount)
FROM sales
GROUP BY customer_id;

-- Sales with product names
SELECT s.sale_id, p.product_name, s.total_amount
FROM sales s
JOIN products p ON s.product_id = p.product_id;

-- Sales with customer names
SELECT s.sale_id, c.customer_name, s.total_amount
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id;

-- Customers who spent more than 300
SELECT customer_id, SUM(total_amount) total_spent
FROM sales
GROUP BY customer_id
HAVING total_spent > 300;

-- Sales above average amount
SELECT *
FROM sales
WHERE total_amount > (SELECT AVG(total_amount) FROM sales);

-- Customers without purchases
SELECT c.customer_name
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;

-- Top product by revenue
SELECT p.product_name, SUM(s.total_amount) revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;

-- Monthly sales summary
SELECT MONTH(sale_date) month, SUM(total_amount) revenue
FROM sales
GROUP BY MONTH(sale_date);


-- Find duplicate customer names
SELECT customer_name, COUNT(*) AS total_count
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;






























