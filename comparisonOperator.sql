-- (I) = operator
-- Retrive all customers from Germany
SELECT *
FROM persons
WHERE country='Germany'

--(II) != operator
--Retrieve all customers who are not from Germany
SELECT *
FROM persons
WHERE country !=  'Germany'

--(III) > operator 
-- Retrieve all customers with a score greater than 500

SELECT *
FROM persons
WHERE score > 500

--(IV) >= operator
-- Retrieve all customers with a score of 300 or more
SELECT *
FROM persons 
WHERE score>=300

--(v) < operator
-- Retrieve all customers with a score less than 500
SELECT *
FROM persons 
WHERE score<500

--(vI) < operator
-- Retrieve all customers with a score 300 or less
SELECT *
FROM persons 
WHERE score<=300






