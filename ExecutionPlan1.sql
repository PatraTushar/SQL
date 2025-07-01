SELECT
p.EnglishProductName AS ProductName,
SUM(s.SalesAmount) AS TotalSales
FROM FactResellerSales s
JOIN DimProduct p
ON p.productKey = s.ProductKey
GROUP BY P.EnglishProductName