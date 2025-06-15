
--Find the average score of the customers

SELECT 
CustomerID,
Score,
COALESCE(score,0) AS AvgScore2,
AVG(score) OVER () AS AvgScores,
AVG(COALESCE(score,0)) OVER() AS Avg_score
FROM Sales.Customers

--Display the fullname of customers in a single field by merging their first and last names and add 10 bonus points to each customers score

SELECT
CustomerID,
FirstName,
LastName,
Score,
COALESCE(FirstName,'') + '' + COALESCE(LastName,'') AS FullName,
COALESCE(score,0) + 10 AS ScoreWithBonus
FROM Sales.Customers


--sort the customers from lowest to highest scores with NULLs appearing last

SELECT 
CustomerID,
Score
FROM Sales.Customers
ORDER BY CASE WHEN SCORE IS NULL THEN 1 ELSE 0 END ,Score

--Find the sales price for each order by dividing the sales by  the quantity

SELECT 
OrderID,
Sales,
Quantity,
sales/NULLIF(Quantity,0) AS price
FROM Sales.Orders

--Identify the customers who have no scores 
SELECT *
FROM Sales.Customers
WHERE Score IS NULL

--List all customers who have scores
SELECT *
FROM Sales.Customers
WHERE Score IS NOT NULL

--List all details for customers who have not placed any order
SELECT
c.*,
o.orderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL




