-- Tip 1-> Select Only What You Need

-- Bad Practice
SELECT * FROM Sales.Customers

--Good Practice
SELECT 
CustomerID,
FirstName,
LastName
FROM Sales.Customers

-- Tip 2-> Avoid Unnecessary DISTINCT AND ORDER BY

-- Bad Practice
SELECT DISTINCT
FirstName
FROM Sales.Customers
ORDER BY FirstName

--Good Practice
SELECT FirstName
FROM Sales.Customers

-- Tip 3-> For Exploration Purpose,Limit Rows

--Bad Practice
SELECT 
OrderID,
Sales
FROM Sales.Orders

--Good Practice
SELECT TOP 10
OrderId,
Sales
FROM Sales.Orders

-- Tip 4-> Create nonclustered Index On Frequently Used Columns in WHERE Clause
SELECT * FROM Sales.Orders WHERE OrderStatus = 'Delivered'

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus) 

-- Tip 5-> Avoid applying functions to columns in WHERE clauses

-- Bad Practice
SELECT * FROM Sales.Orders
WHERE LOWER(Orderstatus) = 'delivered'

-- Good Practice
SELECT * FROM Sales.Orders
WHERE OrderStatus='Delivered'

-- Bad Practice
SELECT * FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025

-- Good Practice
SELECT * FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

-- Tip 6 -> Avoid using wildcards as they prevent index usage

--Bad Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%'

--Good Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%'

--Tip 7 -> use IN instead of multiple OR conditions

--Bad Practice
SELECT *
FROM Sales.Customers
WHERE CustomerID=1 OR CustomerID=2 OR CustomerID=3

--Good Practice
SELECT *
FROM Sales.Customers
WHERE CustomerID IN (1,2,3)

--Tip 8 -> Understand the speed of the join and use INNER JOIN when possible

--Best Perfomance
SELECT C.FirstName,o.OrderID FROM Sales.Customers c INNER JOIN Sales.Orders o ON c.CustomerID=o.CustomerID

--Slightly Slower Perfomance
SELECT C.FirstName,o.OrderID FROM Sales.Customers c RIGHT JOIN Sales.Orders o ON c.CustomerID=o.CustomerID
SELECT C.FirstName,o.OrderID FROM Sales.Customers c LEFT JOIN Sales.Orders o ON c.CustomerID=o.CustomerID


--Worst Perfomance
SELECT C.FirstName,o.OrderID FROM Sales.Customers c OUTER JOIN Sales.Orders o ON c.CustomerID=o.CustomerID

--Tip 9 ->Use Explicit Join (ANSI Join) Intead of Implicit Join(non-ANSI Join)

--Bad Practice
SELECT 
o.OrderID,c.FirstName
FROM Sales.Customers c,Sales.Orders o
WHERE c.customerID=o.CustomerID

--Good Practice
SELECT 
o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID

--Tip 10 -> Make sure to index the columns used in the ON clause
SELECT 
o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID

CREATE CLUSTERED INDEX IX_Orders_CustomerID ON Sales.Orders(CustomerID)


--Tip 11 -> Filter Before Joining (Big Tables)

--Filter After Join(WHERE)
SELECT c.FirstName,o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o           -- For Small And Medium Size Tables
ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus='Delivered'

--Filter During Join(ON)
SELECT c.FirstName,o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
AND o.OrderStatus='Delivered'

--Filter After Join(SUBQUERY)
SELECT c.FirstName,o.OrderID
FROM Sales.Customers c
INNER JOIN (SELECT OrderID,CustomerID FROM Sales.Orders WHERE OrderStatus='Delivered') o
ON c.CustomerID = o.CustomerID             -- For Large Tables
WHERE o.OrderStatus='Delivered' 

--Tip 12 ->  Aggregate Before Joining (Big Tables)

--Best Practice For Small Medium Tables
--Grouping and Joining
SELECT c.CustomerID,c.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,c.FirstName

--Best Practice For Big Tables
--Pre-aggregated Subquery
SELECT c.CustomerID,c.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers c
INNER JOIN(
SELECT CustomerID,c.FirstName,o.OrderCount
FROM Sales.Orders
GROUP BY CustomerID
)o
ON c.CustomerID = o.CustomerID
 
--Bad Practice
--Correlated Subquery
SELECT
c.CustomerID,c.FirstName, 
(SELECT COUNT(o.OrderID) 
FROM Sales.Orders o
WHERE o.CustomerID = c.CustomerID) AS OrderCount
FROM Sales.Customers c

--Tip 13 -> Use Union Instead of OR in Joins

--Bad Practice
SELECT o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID
OR c.CustomerID=o.SalesPersonID

--Good Practice
SELECT o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID
UNION
SELECT o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.SalesPersonID

--Tip 14 -> Check for Nested Loops and Use SQL HINTS

SELECT  o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID

-- Good Practice for Having Big Table and Small Table
SELECT  o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID
OPTION(HASH JOIN)


--Tip 15 -> Use UNION ALL instead of using UNION | duplicates are acceptable

--Bad Praactice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

--Best Practice
SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive

--Tip 16->Use UNION ALL + Distinct instead of using UNION | duplicates are not acceptable

--Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

--Best Practice
SELECT DISTINCT CustomerID
FROM(
    SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive
) AS CombinedData

--Tip17-> Use Columnstore Index for Aggregation on Large Table

SELECT CustomerID,COUNT(OrderID) AS OrderCount 
FROM Sales.Orders
GROUP BY CustomerID

CREATE CLUSTERED INDEX Idx_orders_Columnstore ON Sales.Orders

--Tip18-> Pre-aggregate Data and Store it in new Table For Reporting 

SELECT MONTH(OrderDate) orderYear,SUM(OrderID) AS TotalSales 
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

SELECT OrderYear,TotalSales FROM Sales.SalesSummary

-- Tip19->SUBQUERIES

--JOIN(Best Practice: If the Perfomance equals to EXISTS)
SELECT o.OrderID,o.Sales
FROM Sales.Orders o
INNER JOIN Sales.Customers c
ON o.CustomerID=c.CustomerID
WHERE c.Country='USA'

--EXISTS(Best Practice: Ust it for Large Tables)  
SELECT o.OrderID,o.Sales
FROM Sales.Orders o             -- EXISTS is better than JOIN because it stops at first match and avoid data duplication
WHERE EXISTS(
        SELECT 1
		FROM Sales.Customers c
		WHERE c.CustomerID=o.CustomerID
		AND c.Country='USA'
)

--IN (Bad Practice)
SELECT o.OrderID,o.Sales
FROM Sales.Orders o
WHERE o.CustomerID IN(           --The IN Operator Processes and evaluate all rows it lacks an early exit mechanism
        SELECT CustomerID
		FROM Sales.Customers 
		WHERE Country='USA'
)


-- Tip20->Avoid Redundant logic in your Query

--Bad Practice
SELECT EmployeeID,FirstName, 'Above Average' Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL 
SELECT EmployeeID,FirstName, 'Below Average' Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees)

--Good Practice
SELECT
EmployeeID,
FirstName, 
   CASE
      WHEN Salary > AVG(Salary) OVER() THEN 'Above Average' 
      WHEN Salary <  AVG(Salary) OVER() THEN 'Below Average'
	  ELSE 'Average'
	  END AS Status
FROM Sales.Employees

-- Tip21-> Avoid Datatypes VARCHAR and TEXT

-- Best Practices For Creating Tables

CREATE TABLE customerInfo(
CustomerID INT,
FirstName VARCHAR(MAX),
LastName VARCHAR(50),
Country VARCHAR(255),
TotalPurchases FLOAT,
Score INT,
BirthDate DATE,
EmployeeID INT,
CONSTRAINT FK_CustomerInfo_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Sales.Employees(EmployeeID)
)

 -- Tip22-> Avoid(MAX) unnecessarily ;arge lengths in datatypes

 CREATE TABLE customer(
CustomerID INT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Country VARCHAR(50),
TotalPurchases FLOAT,
Score INT,
BirthDate DATE,
EmployeeID INT,
CONSTRAINT FK_CustomerInfo_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Sales.Employees(EmployeeID)
)


-- Tip23-> Use the NOT NULL Constraints where applicable

 CREATE TABLE customers(
CustomerID INT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Country VARCHAR(50) NOT NULL,
TotalPurchases FLOAT,
Score INT,
BirthDate DATE,
EmployeeID INT,
CONSTRAINT FK_CustomerInfo_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Sales.Employees(EmployeeID)
)

-- Tip24-> Ensure all your tables have a clustered primary key

 CREATE TABLE person(
CustomerID INT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Country VARCHAR(50) NOT NULL,
TotalPurchases FLOAT,
Score INT,
BirthDate DATE,
EmployeeID INT,
CONSTRAINT FK_CustomerInfo_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Sales.Employees(EmployeeID)
)


-- Tip25-> Create a non clusterd index for foreign keys that are used frequently
CREATE TABLE CustomerInformation(
CustomerID INT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Country VARCHAR(50) NOT NULL,
TotalPurchases FLOAT,
Score INT,
BirthDate DATE,
EmployeeID INT,
CONSTRAINT FK_CustomerInfo_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Sales.Employees(EmployeeID)
)

CREATE NONCLUSTERED INDEX IX_Good_Customers_EmployeeID
ON CustomerInformation(EmployeeID)


-- Tip26-> Avoid OverIndexing

-- Tip27-> Drop unused indexes

-- Tip28-> Update Statistics(weekly)

-- Tip29-> Reorganize and Rebuild Indexes(Weekly)

-- Tip30-> Partition Large Table(Facts) To Improve Perfomance
--Next,Apply ColumnStore Index For Best Results
 

























 






 




