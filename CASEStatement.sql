--Create a report showing total sales for each categories:
--High(sales over 50),Medium(sales between 21-50),Low(sales 20 or less)
--sort the categories from highest sales to lowest


SELECT
category,
SUM(sales) AS TotalSales
FROM(
SELECT
OrderID,
Sales,
CASE 
WHEN Sales>50 THEN 'High'
WHEN Sales>20 THEN 'Medium'
ELSE 'Low'
END AS Category
FROM Sales.Orders
)t
GROUP BY category

--Retrieve employee details with gender displayed of full text
SELECT
EmployeeID,
FirstName,
LastName,
Gender,
CASE
WHEN Gender='F' THEN 'Female'
WHEN Gender='M' THEN 'Male'
ELSE 'Not Available'
END AS GenderFullText
FROM Sales.Employees

--Retrieve customer details with abbreviated country code
SELECT 
CustomerID,
FirstName,
LastName,
Country,
--FullForm
CASE 
WHEN Country='Germany' THEN 'DE'
WHEN Country='USA'     THEN  'US'
ELSE 'N/A'
END AS countryAbbr,

--Quick Form
CASE country
WHEN 'Germany' THEN 'DE'
WHEN 'USA' THEN 'US'
ELSE 'N/A'
END AS countryAbbr2

FROM Sales.Customers

--Find the average scores of customers and treat NULLs as 0 And additional provide details such as customerID and LastName
SELECT 
CustomerID,
LastName,
Score,
CASE 
WHEN Score IS NULL THEN 0
ELSE Score
END AS scoreClean,
AVG(CASE 
WHEN Score IS NULL THEN 0
ELSE Score
END ) OVER() AvgCustomerClean,
AVG(Score) OVER() avg_score
FROM sales.Customers

-- Count how many times each customer has made an order with sales greater than 30
SELECT 
CustomerID,
SUM(
CASE 
WHEN Sales>30 THEN 1
ELSE 0
END ) AS TotalOrderHighSales,
COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

SELECT *
FROM Sales.Orders