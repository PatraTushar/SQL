-- Retrieve all persons who are from Germany AND have a score greater than 500

SELECT * FROM persons
WHERE country='Germany' AND score>500

-- Retrieve all persons who are either from India OR have a score greater than 800
SELECT *
FROM persons
WHERE country='India' OR score>700

-- Retrieve all persons with a score not less than 500
SELECT *
FROM persons
WHERE NOT score < 500
