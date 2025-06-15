--Find the total number of customers 
SELECT 
COUNT(*) AS TotalOrders
FROM orders

--Find the total sales of all orders 
SELECT 
SUM(sales) AS TotalSales
FROM orders

--Find the average sales of all orders 
SELECT 
AVG(sales) AS Avg_Sales
FROM orders

--Find the highest score among customers 
SELECT 
MAX(Sales) AS max_Sales
FROM orders

--Find the minimum score among customers 
SELECT 
MIN(Sales) AS Min_Sales
FROM orders







