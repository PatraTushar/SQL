-- Retrieve the lowest 2 customers based on the score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC