 -- VIEW

 --  USE CASES

 --1 ->Central Query Logic

IF OBJECT_ID('Sales.V_Monthly_Summary','V') IS NOT NULL
DROP VIEW Sales.V_Monthly_Summary;

GO
CREATE VIEW Sales.V_Monthly_Summary AS(

SELECT
DATETRUNC(MONTH,OrderDate) AS OrderMonth,
SUM(Sales) AS TotalSales,
COUNT(OrderID) AS TotalOrders,
SUM(Quantity) AS TotalQuantities
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate)
)


SELECT 
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningSales
FROM Sales.V_Monthly_Summary

-- 2 ->Hide Complexity

IF OBJECT_ID('Sales.V_Order_Details','V') IS NOT NULL
DROP VIEW  Sales.V_Order_Details ;

GO

-- Provide a VIEW that combines details from orders,products,customers and employees
CREATE VIEW Sales.V_Order_Details AS (
SELECT 
O.OrderID,
O.OrderDate,
P.Product,
P.Category,
COALESCE(C.FirstName,'') + ' ' + COALESCE(C.LastName,'') AS CustomerName,
C.Country AS CustomerCountry,
COALESCE(E.FirstName,'') + ' ' + COALESCE(E.LastName,'') AS SalesName,
E.Department,
O.Sales,
O.Quantity
FROM Sales.Orders AS O
LEFT JOIN Sales.Products AS P
ON P.ProductID=O.ProductID
LEFT JOIN Sales.Customers AS C
ON C.CustomerID=O.CustomerID
LEFT JOIN Sales.Employees AS E
ON E.EmployeeID=O.SalesPersonID
)


--> Data Security

IF OBJECT_ID('Sales.V_Order_Details_EUR','V') IS NOT NULL
DROP VIEW  Sales.V_Order_Details_EUR ;

GO

-- Provide a VIEW that combines details from orders,products,customers and employees
CREATE VIEW Sales.V_Order_Details_EUR AS (
SELECT 
O.OrderID,
O.OrderDate,
P.Product,
P.Category,
COALESCE(C.FirstName,'') + ' ' + COALESCE(C.LastName,'') AS CustomerName,
C.Country AS CustomerCountry,
COALESCE(E.FirstName,'') + ' ' + COALESCE(E.LastName,'') AS SalesName,
E.Department,
O.Sales,
O.Quantity
FROM Sales.Orders AS O
LEFT JOIN Sales.Products AS P
ON P.ProductID=O.ProductID
LEFT JOIN Sales.Customers AS C
ON C.CustomerID=O.CustomerID
LEFT JOIN Sales.Employees AS E
ON E.EmployeeID=O.SalesPersonID
WHERE C.Country!='USA'
)

SELECT *
FROM Sales.V_Order_Details_EUR
--WHERE CustomerCountry!='USA'


