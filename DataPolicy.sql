WITH Orders AS(
SELECT 1 Id, 'A' category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  '
)


SELECT
*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category),'') Policy2,
COALESCE(NULLIF(TRIM(Category),''),'Unknown') Policy3
FROM Orders
