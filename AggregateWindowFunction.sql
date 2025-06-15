--Find the total number of orders
SELECT
COUNT(*) AS TotalOrders
FROM Sales.Orders

--Find the total number of orders additionally provides details such order id and order date
SELECT
OrderID,
OrderDate,
COUNT(*) OVER() TotalOrders
FROM sales.Orders

--Find the total orders for each customers 
SELECT
OrderID,
OrderDate,
CustomerID,
COUNT(*) OVER(PARTITION BY CustomerID) OrdersByCustomers
FROM sales.Orders

--Find the total number of customers , additionally provide all customers details
SELECT
*,
COUNT(*) OVER() AS TotalCustomers
FROM Sales.Customers

--Find the total number of scores for the customers
SELECT
*,
COUNT(Score) OVER() AS TotalScore
FROM Sales.Customers

--Check whether the table ' orders ' contains any duplicate rows
SELECT
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) AS checkPK
FROM sales.Orders


--Check whether the table ' ordersArchieve ' contains any duplicate rows
SELECT
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) AS checkPK
FROM sales.OrdersArchive

--
SELECT
*
FROM(
SELECT
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) AS checkPK
FROM sales.OrdersArchive
)t
WHERE checkPK>1

--Find the total sales across all orders and total sales for each product.Additionally provide details such as orderID and OrderDate
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
SUM(sales) OVER() Totalsales,
SUM(sales) OVER(PARTITION BY ProductID) AS SalesByProduct
FROM sales.Orders


--Find the percentage contribution of each products sales to the total sales
SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() AS Totalsales,
ROUND(CAST(Sales AS FLOAT)/SUM(Sales) OVER()  * 100,2) AS PercentageContribution
FROM Sales.Orders

--Find the average sales across all orders and average sales for each product.Additionally provides details such as orderID and orderDate
SELECT
OrderID,
OrderDate,
ProductID,
Sales,
AVG(sales) OVER() AS Average,
AVG(sales) OVER(PARTITION BY ProductID) AS AveageOfProduct
FROM Sales.Orders;


--Find the average score of customers.Additionally provide details such as customerID and lastname
SELECT
CustomerID,
LastName,
Score,
COALESCE(Score,0)  AS CustomerScore,
AVG(score) OVER() AS AverageScore,
AVG(COALESCE(Score,0)) OVER() AS AverageScoreWithouNULLs
FROM Sales.Customers

SELECT *
FROM Sales.Customers