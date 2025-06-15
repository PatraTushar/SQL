--Write a SQL query to display the total score for customers from each country
--GROUP BY means pairing together all rows that have the same value in the specified column(s).

SELECT 
country,SUM(score) AS total_score
FROM customers
Group By country

-- internally how it works

/* Group: Germany
  → maria (score 350)
  → martin (score 500)

Group: USA
  → john (score 900)

Group: USA
  → Alice (score 90)
  → peter (score 0)

  Then the aggregation SUM(score) is applied to each group:
Germany-> 350 + 500 = 850
USA->900 + 0 = 900
UK->750


  */