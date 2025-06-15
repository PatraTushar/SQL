-- Add new column called email to the student table

ALTER TABLE students 
ADD email VARCHAR(50) NOT NULL

SELECT *
FROM students