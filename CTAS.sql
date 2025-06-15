IF OBJECT_ID('Sales.MonthlyOrder','U') IS NOT NULL
DROP TABLE Sales.MonthlyOrder;

GO

SELECT
DATENAME(MONTH,OrderDate) AS OrderMonth,
COUNT(OrderID) AS TotalOrders
INTO Sales.MonthlyOrder
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)

SELECT *
FROM Sales.MonthlyOrder