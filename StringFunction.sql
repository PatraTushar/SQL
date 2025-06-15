--Show a list of customers first name together with their country in one column
SELECT
first_name,
country,
CONCAT(first_name,' ',country) AS name_country
FROM customers

-- Convert the firstname to lowercase
SELECT 
first_name,
LOWER(first_name) AS low_name
FROM customers

-- Convert the firstname to uppercase
SELECT 
first_name,
UPPER(first_name) AS low_name
FROM customers

-- Find customers whose first name contains leading or trailing spaces
SELECT
first_name
FROM customers
WHERE first_name!=TRIM(first_name)

--Remove dashes(-) from a phone number 
SELECT 
'123-456-7890' AS Phone_Number,
REPLACE('123-456-7890','-','/') AS updated

--Replace File Extense from txt to csv
SELECT
'report.text' AS old_FileName,
REPLACE('report.txt','txt','csv') AS new_FileName

--Calculate the length of each customers firstName
SELECT
first_name,
LEN(first_name) AS lengthOfName
FROM customers

--Retrieve First Two charcters of each firstName
SELECT
first_name,
LEFT(TRIM(first_name),2) AS extractCharacter
FROM customers

--Retrieve Lat Two character of each firstName
SELECT
first_name,
RIGHT(TRIM(first_name),2) AS extractCharacter
FROM customers


--After second character extract three character
SELECT
first_name,
SUBSTRING(first_name,3,3) AS Extracted_Name
FROM customers

--Retrieve a list of customers first names after removing the first character
SELECT
first_name,
SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS Extracted_Name
FROM customers





