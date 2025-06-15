-- update all customers with a null score by setting their score to 150


UPDATE customers
SET score=150
WHERE score is NULL

SELECT * FROM customers 

