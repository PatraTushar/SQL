--1) CLUSTERED AND NON CLUSTERED  (ON THE BASIS OF STRUCTURE)  

-- Created a table Sales.DBCustomers and copied the details from  Sales.Customers
SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers

-- Filtered the table based on condition
SELECT *
FROM Sales.DBCustomers
WHERE CustomerID=1

-- created a Clustered Index
CREATE CLUSTERED INDEX idx_DBCustomers__CustomerID ON Sales.DBCustomers(CustomerID)


--Deleted a Clustered Index
--DROP INDEX idx_DBCustomers__CustomerID ON Sales.DBCustomers

SELECT *
FROM Sales.DBCustomers
WHERE FirstName='Anna'

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName ON Sales.DBCustomers(LastName)

CREATE NONCLUSTERED INDEX idx_DBCustomers_FirstName ON Sales.DBCustomers(FirstName)

SELECT *
FROM Sales.DBCustomers
WHERE Country='USA' AND Score>500



CREATE  INDEX idx_DBCustomers_CountryScore ON Sales.DBCustomers(Country,Score)


--2)ROWSTORE INDEX AND COLUMNSTORE INDEX (ON THE BASIS OF STORAGE)




