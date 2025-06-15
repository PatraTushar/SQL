-- 1) RESULT TYPE

--(I) SCALAR SUBQUERY
SELECT
AVG(Sales) AS Average
FROM Sales.Orders;

--(II) ROW SUBQUERY
SELECT
CustomerID
FROM Sales.Orders

--(III) TABLE SUBQUERY
SELECT
*
FROM Sales.Orders


--(2) LOCATION/CLAUSE

--Subquery in FROM clause

--Find the product that have a price higher than the average price of all products
--MainQuery
SELECT
*
FROM
--Subquery
(SELECT
ProductID,
Price,
AVG(Price) OVER() AvgPrice
FROM
Sales.Products
)t
WHERE Price>AvgPrice

--Rank customers based on their total amount of sales
--Mainquery
SELECT 
*,
RANK() OVER(ORDER BY TotalSales DESC) AS Ranks
FROM
(
--Subquery
SELECT
CustomerID,
SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)t

--Show the Product IDs,names,Prices and total number of orders
--Mainquery
SELECT
ProductId,
Product,
Price,
--Subquery
(SELECT COUNT(*) FROM Sales.Orders) AS TotalOrders
FROM Sales.Products;

--Show all customer details and find the total orders for each customers
SELECT 
C.*,
O.TotalOrder
FROM Sales.Customers AS C

LEFT JOIN(

SELECT 
CustomerID,
COUNT(*) AS TotalOrder
FROM Sales.Orders 
GROUP BY CustomerID

) AS O
ON C.CustomerID=O.CustomerID

--Find the product that have a price higher than the average price of all products
SELECT 
Product,
Price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) AS AvgPrice FROM Sales.Products)

--Show the details of orders made by customer in Germany
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country='Germany')


--Show the details of orders made by customer who are not from Germany
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country!='Germany')

--Find female employees whose salries are greater than the salaries of any male employees
SELECT
FirstName,
EmployeeID,
Gender,
Salary
FROM Sales.Employees
WHERE Gender='F'
AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender='M')

--Find female employees whose salaries are greater than the salaries of all male employees
SELECT
FirstName,
EmployeeID,
Gender,
Salary
FROM Sales.Employees
WHERE Gender='F'
AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender='M')

--Show all customer details and find the total orders for each customers

SELECT *,
(SELECT COUNT(*) FROM Sales.Orders AS O WHERE O.CustomerID=C.CustomerID) AS TotalSales 
FROM Sales.Customers AS C 

SELECT * FROM Sales.Orders
SELECT * FROM Sales.Customers

--Show the details of orders made by customers in Germany
SELECT *
FROM Sales.Orders AS O
WHERE EXISTS ( SELECT *
               FROM Sales.Customers AS C
               WHERE Country='Germany'
			   AND O.CustomerID=C.CustomerID)



--Show the details of orders made by customers not from Germany
SELECT *
FROM Sales.Orders AS O
WHERE NOT EXISTS ( SELECT *
               FROM Sales.Customers AS C
               WHERE Country='Germany'
			   AND O.CustomerID=C.CustomerID)











