SELECT *
FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Category
ON Sales.Products(Product)

SELECT * 
FROM Sales.Customers
WHERE Country='USA'

CREATE NONCLUSTERED INDEX idx_Customer_Country
ON Sales.Customers(Country)
WHERE Country='USA'