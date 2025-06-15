-- Retrieve top 3 customers with the highest score
SELECT TOP 3
*
FROM customers
ORDER BY score DESC