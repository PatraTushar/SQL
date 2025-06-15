--Find the total sales across all orders

SELECT
SUM(Sales) AS TotalSales
FROM Sales.Orders

--Find the total sales for each product
SELECT
ProductID,
SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY ProductID

--Find the total sales across all orders  additionally provide details such as order id and order date
SELECT 
OrderID,
OrderDate,
SUM(Sales) OVER() TotalSales
FROM Sales.Orders

--Find the total sales for each product  additionally provide details such as order id and order date
SELECT 
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSales
FROM Sales.Orders

--Find the total sales for each combination of product and order status
SELECT
OrderID,
OrderDate,
ProductID,
OrderStatus,
sales,
SUM(Sales) OVER(PARTITION BY ProductID , OrderStatus) AS SalesByProductAndStatus
FROM Sales.Orders

--Rank each order based on their sales from highest to lowest,additionally provide details such order id and order date
SELECT
OrderID,
ProductID
OrderDate,
Sales,
RANK() OVER(ORDER BY sales DESC) AS Rank
FROM Sales.Orders


--RANK OVER(PARTITION BY PRODUCTID,ORDER BY SALES)
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
RANK() OVER(PARTITION BY ProductID ORDER BY sales ) AS Rank
FROM Sales.Orders


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(sales) OVER(PARTITION BY orderStatus ORDER BY orderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales
FROM sales.Orders

--Frame clause

--1) OVER(ORDER BY ORDERID ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
SELECT
OrderID,
ProductID,
sales,
SUM(sales)
OVER(ORDER BY OrderID ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales
FROM Sales.Orders

--2) OVER(ORDER BY ORDERID ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
SELECT
OrderID,
ProductID,
sales,
SUM(sales)
OVER(
ORDER BY OrderID 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
)
AS TotalSales
FROM Sales.Orders
ORDER BY OrderID


--3) OVER(ORDER BY ORDERID ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
SELECT
OrderID,
ProductID,
sales,
SUM(sales)
OVER(
ORDER BY OrderID 
ROWS BETWEEN  1 PRECEDING AND CURRENT ROW
)
AS TotalSales
FROM Sales.Orders
ORDER BY OrderID

--4) OVER(ORDER BY ORDERID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
SELECT
OrderID,
ProductID,
sales,
SUM(sales)
OVER(
ORDER BY OrderID 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
AS TotalSales
FROM Sales.Orders
ORDER BY OrderID

--5) OVER(ORDER BY ORDERID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
SELECT
OrderID,
ProductID,
sales,
SUM(sales)
OVER(
ORDER BY OrderID 
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
)
AS TotalSales
FROM Sales.Orders
ORDER BY OrderID

--6) OVER(ORDER BY ORDERID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
SELECT
OrderID,
ProductID,
sales,
SUM(sales)
OVER(
ORDER BY OrderID 
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
AS TotalSales
FROM Sales.Orders
ORDER BY OrderID

--Find the total sales for each order status only for two products 101 and 102
SELECT
OrderID,
OrderDate,
OrderStatus,
ProductID,
Sales,
SUM(sales) OVER(PARTITION BY OrderStatus) AS TotalSales
FROM sales.Orders
WHERE ProductID IN(101,102)

--Rank customer based on their total sales
SELECT
CustomerID,
SUM(Sales) AS TotalSales,
RANK() OVER(ORDER BY SUM(Sales)) AS Ranks
FROM sales.Orders
GROUP BY CustomerID 




SELECT *
FROM Sales.Orders