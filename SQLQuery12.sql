--Write an SQL query to find the total score of customers, grouped by their country and first name
SELECT
country,first_name,
SUM(score) As total_score
FROM customers
GROUP BY 
country,first_name

