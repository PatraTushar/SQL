--Get All customers who havent placed any order
-- (I) LEFT ANTI JOIN
SELECT * FROM TableA
SELECT * FROM orders

SELECT
T.ID,
T.student_name,
O.order_id,
O.sales
FROM TableA as T
LEFT JOIN orders as O
ON T.ID=O.customer_id
WHERE O.customer_id IS NULL

--Get All the orders without matching customers
--(II)RIGHT ANTI JOIN

SELECT
T.ID,
T.student_name,
O.order_id,
O.sales
FROM TableA AS T
RIGHT JOIN orders AS O
ON T.ID=O.customer_id
WHERE T.ID IS NULL

-- Get All the orders without matching customers(using LEFT JOIN)
-- Alternative of RIGHT ANTI JOIN
SELECT 
T.ID,
T.student_name,
O.order_id,
O.sales
FROM orders AS O
LEFT JOIN TableA AS T
ON T.ID=O.customer_id
WHERE T.ID is NULL

--Find All customers without orders and orders without customers
--(III) FULL ANTI JOIN
SELECT 
T.ID,
T.student_name,
O.order_id,
O.sales
FROM TableA AS T
FULL JOIN orders AS O
ON T.ID=O.customer_id
WHERE T.ID IS NULL OR O.customer_id IS NULL

--Get all customers along with their orders but only for customers who have placed an order(without using INNER JOIN)
-- ADVANCED INNER JOIN
SELECT 
T.ID,
T.student_name,
O.order_id,
O.sales
FROM TableA AS T
LEFT JOIN orders AS O
ON T.ID=O.customer_id
WHERE O.customer_id IS NOT NULL

--Generate All possible combinations of TableA  and orders
--(IV)CROSS JOIN
SELECT *
FROM TableA
CROSS JOIN orders


