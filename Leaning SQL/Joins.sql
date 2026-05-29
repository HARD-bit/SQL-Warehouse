USE MyDatabase

--INNER JOIN is used for taking only the intersection between tables
SELECT *
FROM customers
INNER JOIN orders
ON id = customer_id

--LEFT JOIN/ RIGHT JOIN is used for taking all the data from the left table, united with the matching data from the right table
--FULL JOIN is used for taking all the data from the tables, even where there isn't a intersection

SELECT *
FROM customers
LEFT JOIN orders
ON id = customer_id

--ADVANCE JOINS

--LEFT ANTI JOIN is used for returning rows from the left table that have no match with the right table, same with RIGHT ANTI JOIN and FULL ANTI JOIN
--we have to specify the filter where selecting all the rows that have no mach with the function IS NULL or IS NOT NULL

SELECT *
FROM customers
LEFT JOIN orders
ON id = customer_id
WHERE customer_id IS NULL

--CROSS JOIN  combines every row from the firts table with every rows from the other table, forming all possible combination

SELECT * 
FROM customers
CROSS JOIN orders

--we have to specify from what table the data is picked
USE SalesDB

SELECT 
o.OrderID,
o.Sales,
c.FirstName,
c.LastName,
p.Product AS productName,
p.Price,
e.LastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID

--ORDER BY is allowed only once at the end of the query

--UNION is used to join togheter more selections, with the same number of columns, where the data types are compatible
--EXCEPT makes all the data selected removed from the final result
--INTERSECT returns common rows between tables

SELECT FirstName,LastName
FROM Sales.Customers

UNION ALL

SELECT FirstName,LastName
FROM Sales.Employees

--The column names in the resut set are determined by the column names specified in the first query
--The ; symbol ends makes the mark for where one query ends

SELECT *
FROM Sales.Orders

UNION ALL

SELECT *
FROM Sales.OrdersArchive


--LEFT ANTI JOIN returns all rows from the left table, without matches in the right table

