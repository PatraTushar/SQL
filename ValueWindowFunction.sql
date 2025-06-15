--Analyze the month-over-month performance by finding the percentage change in sales between the current and previous month
SELECT
*,
CurrentMonthSales-PreviousMonthSales AS MoMChange,
ROUND(CAST((CurrentMonthSales-PreviousMonthSales)AS FLOAT)/PreviousMonthSales*100,1)AS MoM_Perc
FROM(
SELECT
MONTH(OrderDate) AS Months,
SUM(Sales) AS CurrentMonthSales,
LAG( SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
FROM Sales.Orders
GROUP BY(MONTH(OrderDate))
)t

--In order to analyze customer loyalty rank customers based on the average days between their orders
SELECT
CustomerID,
AVG(DaysUntilNextOrder) AS Average,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder),9999 )) AS Ranks
FROM(
SELECT
OrderID,
CustomerID,
OrderDate AS CurrentOrder,
LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
DATEDIFF(DAY,OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
FROM Sales.Orders
)t
GROUP BY CustomerID

--Find the lowest and highest sales for each product and find the difference in sales between the current and lowest sales
SELECT
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING ) AS HighestSales,
Sales-FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS SalesDifference

--FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS UsingFirstValueToFindHighest,
--MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSales1,
--MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSales1
FROM sales.Orders

--

SELECT 
OrderID,
ProductID,
Sales
FROM sales.Orders

