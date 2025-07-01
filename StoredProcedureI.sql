--Step 1 : Write a Query
-- For US Customers Find the Total Number Of Customers and the Average Score

SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country ='USA'

--Step 2 : Turning the Query Into a Stored Procedure

CREATE PROCEDURE GetCustomerSummary AS
BEGIN
SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country ='USA'
END

-- Step 3: Execute the Stored Procedure

EXEC GetCustomerSummary

-- For German Customers Find the Total Number Of Customers And The Average 
CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country ='GERMANY'
END

EXEC GetCustomerSummaryGermany







