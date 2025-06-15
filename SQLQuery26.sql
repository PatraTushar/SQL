-- change the score of customers with ID 6 to 0
SELECT * FROM customers

UPDATE customers
SET score=0
WHERE id=6

SELECT * FROM customers
WHERE id = 6