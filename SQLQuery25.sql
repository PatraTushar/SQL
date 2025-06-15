
-- copy data from customers table into students 
INSERT INTO Students(student_name,birth_date,phone)
SELECT
first_name,
NULL,
'UNKNOWN'
FROM customers

SELECT DISTINCT student_name,birth_date,phone  FROM Students

