USE MyDatabase

SELECT first_name,country,score
FROM customers
WHERE (score != 0)

SELECT first_name,country,score
FROM customers
WHERE country = 'Germany'

SELECT first_name,country,score
FROM customers
ORDER BY 
Country ASC,
Score DESC


USE MyDatabase
SELECT country,
SUM(score) AS total_score,
COUNT(id) AS total_customers
FROM customers
GROUP BY country
HAVING SUM(score) > 800

-- All colums in the SELECT must be either aggregated or included in the GROUP BY
-- HAVING for data filtering after aggregation
-- FILTER is used for filtering the table before those operations, using WHERE	


SELECT country,
AVG(score) AS average_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) >= 430

-- DISTINCT is used to remove dublicated values

SELECT DISTINCT country
FROM customers

-- TOP restrict the number of rows returned

SELECT TOP 3 *
FROM customers
ORDER BY score DESC