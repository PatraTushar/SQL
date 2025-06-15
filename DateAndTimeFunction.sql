--DATE AND TIME FUNCTION
USE SalesDB

SELECT 
OrderID,
CreationTime,
'2025-08-20' AS HardCoded,
GETDATE() AS TODAY
FROM Sales.Orders

-- 1->PART EXTRACTION

--(I) DAY()  MONTH()  YEAR()
SELECT 
OrderID,
CreationTime,
DAY(creationTime) AS DAYS,
MONTH(creationTime) AS MONTHS,
YEAR(creationTime) AS YEARS
FROM Sales.Orders

--(II) DATEPART()
--Quarter	Months
--Q1	Jan, Feb, Mar
--Q2	Apr, May, Jun
--Q3	Jul, Aug, Sep
--Q4	Oct, Nov, Dec
SELECT 
OrderID,
CreationTime,
DATEPART(YEAR,CreationTime) AS Year_DP,
DATEPART(MONTH,CreationTime) AS Month_DP,
DATEPART(DAY,CreationTime) AS Day_DP,
DATEPART(HOUR,CreationTime) AS Hour_DP,
DATEPART(QUARTER,CreationTime) AS Quarter_DP,
DATEPART(WEEK,CreationTime) AS Week_DP
FROM Sales.Orders

--(III) DATENAME()
SELECT 
OrderID,
CreationTime,
DATENAME(YEAR,CreationTime) AS Year_DP,
DATENAME(MONTH,CreationTime) AS Month_DP,
DATENAME(WEEKDAY,CreationTime) AS Week_DP
FROM Sales.Orders

--(III) DATETRUNC

SELECT 
OrderID,
CreationTime,
DATETRUNC(HOUR,CreationTime) AS HOUR_DT,
DATETRUNC(MINUTE,CreationTime) AS MINUTE_DT,
DATETRUNC(SECOND,CreationTime) AS SECOND_DT,
DATETRUNC(YEAR,CreationTime) AS Year_DP,
DATETRUNC(MONTH,CreationTime) AS Month_DP,
DATETRUNC(DAY,CreationTime) AS DAY_DP
FROM Sales.Orders

SELECT
DATETRUNC(MONTH,CreationTime) AS Creation,
COUNT(*) AS month
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,creationTime)

SELECT
DATETRUNC(YEAR,CreationTime) AS Creation,
COUNT(*) AS year
FROM Sales.Orders
GROUP BY DATETRUNC(YEAR,creationTime) 

--(IV) EOMONTH
SELECT
OrderId,
creationTime,
EOMONTH(creationTime) AS last_day,
CAST(DATETRUNC(MONTH,CreationTime) AS DATE) AS startOfMonth
FROM Sales.Orders

-- How many orders were placed each year
SELECT
YEAR(OrderDate) AS year,
COUNT(*) AS noOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- How many orders were placed each month
SELECT
DATENAME(MONTH,OrderDate) AS month,
COUNT(*) AS noOfOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate) 

-- Show all orders that were palces during the month of february
SELECT
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

-- 2->FORMAT AND CASTING

--(I) FORMAT
SELECT
OrderID,
CreationTime,
FORMAT(creationTime,'MM-dd-yyyy') AS USA_FORMAT,
FORMAT(creationTime,'dd-MM-yyyy') AS EURO_FORMAT,
FORMAT(creationTime,'dd') AS dd,
FORMAT(creationTime,'ddd') AS ddd,
FORMAT(creationTime,'dddd') AS dddd,
FORMAT(creationTime,'MM') AS MM,
FORMAT(creationTime,'MMM') AS MMM,
FORMAT(creationTime,'MMMM') AS MMMM
FROM Sales.Orders

-- Show creation time using the following format
-- DAY WED JAN Q1 2025 12:34:56 PM 

SELECT
OrderID,
CreationTime,
'Day' +' ' + FORMAT(creationTime ,'ddd MMM' ) + ' ' + 'Q' +DATENAME(QUARTER,CreationTime) + ' ' + FORMAT(CreationTime,'yyyy hh:mm:ss tt') AS customeFormat
FROM Sales.Orders

SELECT
FORMAT(OrderDate,'MMM yy') AS orderDate,
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')

--(II)CONVERT
SELECT
CONVERT(INT,'123') AS stringToInt,
CONVERT(DATE,'2025-08-20') AS stringToDate,
CONVERT(DATE,creationTime) dateTimeToDateConvert,
CONVERT(VARCHAR,CreationTime,32) AS [USA Std. Style:32],
CONVERT(VARCHAR,CreationTime,34) AS [USA Std. Style:34]
FROM Sales.Orders

SELECT * FROM sales.Orders

-- (III) CAST
SELECT
CAST('123' AS INT) AS [String To Int],
CAST(123 AS VARCHAR) AS [Int To Varchar],
CAST('2025-08-20' AS DATE) AS  [Varchar To Date],
CAST('2025-08-20' AS DATETIME2) AS  [Varchar To DateTime],
creationTime,
CAST(CreationTime AS DATE) AS [DateTime To Date]
FROM Sales.Orders

-- 3->CALCULATIONS

--(I) DATEADD

SELECT
OrderID,
OrderDate,
DATEADD(YEAR,3,OrderDate) AS ThreeYearsLater,
DATEADD(MONTH,2,OrderDate) AS TwoMonthsLater,
DATEADD(DAY,4,OrderDate) AS FourDayLater
FROM Sales.Orders

-- (II) DATEDIFF

-- Calculate The age of employee
SELECT 
EmployeeID,
BirthDate,
DATEDIFF(YEAR,BirthDate,GETDATE()) AS Age
FROM Sales.Employees

-- Find the shipping duration in days for each month

SELECT
OrderID,
OrderDate,
ShipDate,
DATEDIFF(DAY,OrderDate,ShipDate) AS ShippingDuration
FROM Sales.Orders


-- Find the average shipping duration in days for each month

SELECT
MONTH(OrderDate) AS orderDate,
AVG(DATEDIFF(DAY,OrderDate,ShipDate)) AS ShippingDuration
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- Find the number of days between each order and previous order
SELECT 
OrderID,
OrderDate,
LAG(orderDate) OVER (ORDER BY orderDate) AS previousSales,
DATEDIFF(DAY,LAG(orderDate) OVER (ORDER BY orderDate),OrderDate)  AS NoOfDays
FROM Sales.Orders

-- 4->VALIDATION

--(I) ISDATE

SELECT
ISDATE('123') AS DateCheck1,
ISDATE('2025-08-20') AS DateCheck2,
ISDATE('2025') AS DateCheck3,
ISDATE('20-08-2025') AS DateCheck4 -- The format is wrong so it will give 0

SELECT
orderDate,
ISDATE(orderDate),
CASE WHEN ISDATE(OrderDate)=1 THEN CAST(OrderDate AS DATE)
ELSE '9999-01-01'
END AS  NewOrderDate
FROM (
SELECT '2025-08-20' AS orderDate UNION
SELECT '2025-08-21' UNION
SELECT '2025-08-23' UNION
SELECT '2025-08'
)t













