SELECT
p.EnglishProductName AS ProductName,
SUM(s.SalesAmount) AS TotalSales
FROM FactResellerSales_HP s
JOIN DimProduct p
ON p.productKey = s.ProductKey
GROUP BY P.EnglishProductName

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactResellerSalesHP
ON FactResellerSales_HP