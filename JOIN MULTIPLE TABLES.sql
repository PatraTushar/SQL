--Using salesDB retrieve all list of orders along with the related customers ,product and employee details.For each order,display:orderID,customers name,product name,sales amount,product price,salespersons name.
USE SalesDB

SELECT 
O.OrderID,
O.Sales,
C.FirstName AS customerFirstName,
c.LastName AS customerLastName,
P.Product AS product_name,
P.Price,
E.FirstName AS EmployeeFirstName,
E.LastName AS EmployeeLastName
FROM Sales.Orders AS O
LEFT JOIN Sales.Customers AS C
ON O.OrderID=C.CustomerID
LEFT JOIN Sales.Products AS P
ON O.ProductID=P.ProductID
LEFT JOIN Sales.Employees AS E
ON O.SalesPersonID=E.EmployeeID