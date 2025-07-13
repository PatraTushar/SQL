SELECT * FROM customers
SELECT * FROM orders

--📘 1. UNION – Combine Customer and Order Customer IDs

SELECT id FROM customers
UNION 
SELECT customer_id from orders

-- 2. UNION ALL – Include Duplicates

SELECT id FROM customers
UNION ALL
SELECT customer_id from orders

--3.INTERSECT – Common Customer IDs in both Tables

SELECT id FROM customers
INTERSECT
SELECT customer_id from orders

-- 4. EXCEPT / MINUS – Difference

SELECT id FROM customers
EXCEPT
SELECT customer_id from orders

--Real Example: Combine Names from Different Countries

SELECT first_name FROM customers WHERE country='Germany'
UNION 
SELECT first_name FROM customers WHERE country='USA'

--  Example 1: Find customers who placed orders and are from Germany


SELECT  first_name FROM customers
WHERE id IN(SELECT id FROM customers WHERE country='Germany'
INTERSECT
SELECT customer_id FROM orders 
)


-- Example 2: Find customers who have placed orders in the past — and those who haven't

-- (a) Have ordered:

 SELECT first_name FROM customers
 WHERE id
         IN( SELECT id FROM customers
               INTERSECT 
            SELECT  customer_id FROM orders
             )

 
 -- (b) Have not ordered:

 SELECT first_name FROM customers
 WHERE id
         IN( SELECT id FROM customers
               EXCEPT 
            SELECT  customer_id FROM orders
             )


--  Example 3: Combine customers from USA and UK without duplicates

SELECT  first_name FROM customers WHERE country='USA'
UNION
SELECT  first_name FROM customers WHERE country='UK'


-- Example 4: Find names that are common between German and USA customers
	
SELECT first_name FROM customers WHERE country = 'USA'
UNION
SELECT first_name FROM customers WHERE country = 'UK';

	
--  Example 5: Find customers who are NOT from Germany or UK


SELECT first_name FROM customers
EXCEPT
     (SELECT first_name FROM customers  WHERE country='Germany'
	  UNION
	  SELECT first_name FROM customers  WHERE country='USA'
	  )

--  Example 6: Find customers who ordered but are not in your customer list (Data Quality Check)

SELECT customer_id FROM orders
EXCEPT
SELECT id FROM customers

--  Example 7: Add a column to indicate data source

SELECT id , 'From_customers' AS source FROM customers
UNION ALL 
SELECT customer_id,'From_orders' AS source  FROM orders

-- Example 8: Combine two filtered segments and analyze overlap

-- All German and high-value customers
SELECT id FROM customers WHERE country = 'Germany'
UNION
SELECT id FROM customers WHERE score > 600;



	  








