-- (i) LIKE
--Find all the persons whose names starts with 'M'
SELECT *
FROM persons
WHERE names LIKE 'M%'

 --Find all the persons whose names ends with 't'
SELECT *
from persons
WHERE names LIKE '%T'

--Find all the persons whose names contains 'R'
SELECT *
from persons
WHERE names LIKE '%R%'

--Find all the persons whose names has 'i' in the third position
SELECT *
from persons
WHERE names LIKE '__I%'



