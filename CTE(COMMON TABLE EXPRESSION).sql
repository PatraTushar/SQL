
--1)Non Recursive CTE

-- Step 1 : Find the total sales per customer(StandAlone CTE)

WITH CTE_Total_Sales AS
(
SELECT 
CustomerID,
SUM(Sales) As TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)

-- Step 2:Find the last order date for each customer(StandAlone CTE)
, CTE_LastOrder AS
(
SELECT
CustomerID,
MAX(OrderDate) AS LastOrder
FROM Sales.Orders
GROUP BY CustomerID
)

-- Step 3 : Rank customers based on Total Sales per customer(Nested CTE)
, CTE_CustomerRank AS
(
SELECT
CustomerID,
TotalSales,
RANK() OVER(ORDER BY TotalSales) AS CustomerRank
FROM CTE_Total_Sales
)

-- Step 4: Segment customers based on their total sales(Nested CTE)
,CTE_CustomerSegment AS
(
SELECT
CustomerID,
CASE WHEN TotalSales > 100 THEN 'High'
     WHEN TotalSales > 50 THEN 'Medium'
	 ELSE 'Low'
END CustomerSegment
FROM  CTE_Total_Sales
)
--Main Query
SELECT
C.CustomerID,
C.FirstName,
C.LastName,
CTS.TotalSales,
CTL.LastOrder,
CCR.CustomerRank,
CCS.CustomerSegment
FROM Sales.Customers AS C
LEFT JOIN CTE_Total_Sales AS CTS
ON CTS.CustomerID=C.CustomerID
LEFT JOIN CTE_LastOrder AS CTL
ON CTL.CustomerID=C.CustomerID
LEFT JOIN CTE_CustomerRank AS CCR
ON CCR.CustomerID=C.CustomerID
LEFT JOIN CTE_CustomerSegment AS CCS
ON CCS.CustomerID=C.CustomerID



--2)Recursive CTE

--Generate a sequence of number from 1 to 20

WITH Series AS
(
--Anchor Query
    SELECT
    1 AS MyNumber
    UNION ALL

	--Recursive Query
	SELECT
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 100

)
--Main Query
SELECT *
FROM Series
OPTION(MAXRECURSION 1000)  -- YOU CAN SET THE LIMIT BECAUSE THE DEFAULT IS 100 AND MORE THAN 100 NUMBER YOU CANT PRINT IT GIVES ERROR TO PRINT MORE THAN 100 YOU HAVE TO USE THIS OPTION


--Show the employee hierarchy by displaying each employees level within the organization
WITH CTE_EmployeeHierarchy AS
(
--Anchor Query
   SELECT 
   EmployeeID,
   FirstName,
   ManagerID,
   1 AS Level
   FROM Sales.Employees
   WHERE ManagerID IS NULL
   UNION ALL
   --Recursive Query
   SELECT
     e.EmployeeID,
     e.FirstName,
	 e.ManagerID,
	  Level + 1
	 FROM Sales.Employees AS e
	 INNER JOIN CTE_EmployeeHierarchy AS ceh
	 ON e.ManagerID=ceh.EmployeeID

)

--Main Query

SELECT *
FROM  CTE_EmployeeHierarchy


