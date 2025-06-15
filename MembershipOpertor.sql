--(I) IN 
--Retrieve all persons from either India or England
SELECT * FROM persons
WHERE country IN ('India','England') 

--(II)NOT IN
--Retrieve all persons not from from  India or England
SELECT * FROM persons
WHERE country NOT IN ('India','England') 