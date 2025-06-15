--Retrieve all data from Table A and Table B with separate result
--(I) NO JOIN
SELECT * FROM TableA
SELECT * FROM TableB
SELECT * FROM orders

--Get all persons along with their orders but only for persons who have placed the order
--(II) INNER JOIN
SELECT 
ID,
student_name,
order_id,
sales
FROM TableA
INNER JOIN orders
ON TableA.ID=orders.customer_id

-- Get all rows from left and only matching from right 
--(III) LEFT JOIN
SELECT 
T.ID,
T.student_name,
O.order_id,
O.sales

FROM TableA AS T
LEFT JOIN orders AS O
ON T.ID=O.customer_id

--(IV) RIGHT JOIN
-- Get all persons along with their orders including orders without matching persons 

SELECT
T.ID,
T.student_name,
O.order_id,
O.sales
FROM TableA AS T
RIGHT JOIN orders AS O
ON T.ID=O.customer_id

-- Alternative to RIGHT JOIN
SELECT
T.ID,
T.student_name,
O.order_id,
O.sales
FROM orders AS O
LEFT JOIN TableA AS T
ON T.ID=O.customer_id

--(V) FULL JOIN
--Get all customers and all orders even if there is no match

SELECT
T.ID,
T.student_name,
O.order_id,
O.sales
FROM TableA AS T
FULL JOIN orders AS O
ON T.ID=O.customer_id






