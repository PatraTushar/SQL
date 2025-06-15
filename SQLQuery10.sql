-- Write a SQL query to retrieve all customer details sorted by country in alphabetical order and, within each country, by highest to lowest score

SELECT *
FROM customers
ORDER BY
country ASC,       -- It first sorts by country (alphabetically),
score DESC                --and only then, if two or more country have the same name, it sorts those by DESC.
