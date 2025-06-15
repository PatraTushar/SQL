-- find the average score of each country considering only customers with a score not equal to 0 and return only those countries with the average score greater tha 430.

SELECT 
country,
AVG(score) AS avg_score
FROM customers
WHERE score!=0
GROUP BY country
HAVING AVG(score)>430
