-- Combine the data from employees and customers into one table
--(I) UNION
SELECT 
FirstName,
LastName
FROM Sales.Customers

UNION

SELECT 
FirstName,
LastName
FROM Sales.Employees

-- Combine the data from employees and customers into one table including duplicates
--(II) UNION ALL
SELECT 
FirstName,
LastName
FROM Sales.Customers

UNION ALL

SELECT 
FirstName,
LastName
FROM Sales.Employees

--Find Employees who are not customers at the same time
--(III) EXCEPT
SELECT 
FirstName,
LastName
FROM Sales.Customers

EXCEPT

SELECT 
FirstName,
LastName
FROM Sales.Employees

--Find employees who are also customers
--(IV) INTERSECT

SELECT 
FirstName,
LastName
FROM Sales.Customers

INTERSECT

SELECT 
FirstName,
LastName
FROM Sales.Employees

-- Orders are stored in separate tables (orders and ordersArchieve).combine all orders into one report without duplicates
SELECT 
'orders' AS sourceTable,
[OrderID],
[ProductID],
[CustomerID],
[SalesPersonID],
[OrderDate],
[ShipDate],
[OrderStatus],
[ShipAddress],
[BillAddress],
[Quantity],
[Sales],
[CreationTime]
FROM Sales.Orders

UNION

SELECT
'ordersArchieve' AS sourceTable,
[OrderID],
[ProductID],
[CustomerID],
[SalesPersonID],
[OrderDate],
[ShipDate],
[OrderStatus],
[ShipAddress],
[BillAddress],
[Quantity],
[Sales],
[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID


