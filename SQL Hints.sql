SELECT
o.Sales,
c.Country
FROM Sales.Orders o
LEFT JOIN Sales.Customers c   -- WITH (FORCESEEK)
ON o.CustomerId = c.CustomerId
OPTION (HASH JOIN)