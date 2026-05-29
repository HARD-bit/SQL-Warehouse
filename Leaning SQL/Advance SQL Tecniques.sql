--DATABASE ENGINE: It is the brain of the database, executing multiple operations such a storing, retrieving, and managing data within
--the database

--SYSTEM CATALOG: Database's internal storage for its own information. A blueprint that keeps track of everything about the database itself,
--not the user data. It holds the metadata information about the database.

--INFORMATION SCHEMA: A system defined schema with build-in views that provide info about the database, like tables and columns.

SELECT 
DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS

--TEMP DATA STORAGE: Temporary space used by the database for short-term tasks(Inside System Databases;tempdb)

--IN/ NOT IN: will checks whether a value matches any value from a list or not
ALTER DATABASE SalesDB
SET COMPATIBILITY_LEVEL = 160;

USE SalesDB
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Sales.Customers
	WHERE Country = 'Germany')

--ANY: checks if a value matches any value within a list
--ALL: checks if a value matches all values within a list


SELECT 
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F' AND 
Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M')


--CURRELATED and UNCORRELATED subquery: dependent or indipendent from the main query, executed for each row and
--processed or executed once and it's result is used by the main query, row-by-row comparison and dynamic filtering
--or static comparison and filtering with constantas


--EXISTS / NOT EXIST : checks the existence of a row within different tables

SELECT *
FROM Sales.Orders AS o 
WHERE EXISTS (SELECT *
	FROM Sales.Customers AS c
	WHERE Country = 'Germany' AND o.CustomerID = C.CustomerID)

--COMMON TABLE EXPRESSIONS(CTE)
--Temporary, named result set(virtual table), that can be used multiples times within a query to simplify and
--organize complex query

--STANDALONE CTE: Defined and used independently. Runs independently as it's self-contained and doesn't rely
--on other  CTEs or queries(connot use ORDER BY)

WITH CTE_Total_Sales AS
	(
	SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
	)

SELECT 
c.CustomerID,
c.FirstName,
c.LastName
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cte
ON cte.CustomerID = c.CustomerID

--RECURSIVE CTE: Self-referecing query that repeatedly processes data until a specific condition is met

--Anchor Query
WITH Series AS(
	SELECT 
	1 AS My_number
	UNION ALL
	--Recursive Query
	SELECT 
	My_number + 1
	FROM Series
	WHERE My_number < 20
)
--Main Query
SELECT *
FROM Series

--


WITH CTE_Emp_Hierarchy AS
(
	--Anchor Query
	SELECT 
	EmployeeID,
	FirstName,
	ManagerID,
	1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL

	--Recursive Query
	SELECT 
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	Level + 1
	FROM Sales.Employees AS e
	INNER JOIN CTE_Emp_Hierarchy AS Ceh
	ON e.ManagerID = Ceh.EmployeeID

)
--Main Query
SELECT *
FROM CTE_Emp_Hierarchy


--DATABASE SERVER: Stores,manages and provides access to databases for user or applications	
--DATABASE: Collection of information that is stored in a structured way
--SCHEMA: Logical layer that groups related objects togheter
--TABLE: a place where data is stored and organized into rows and columns
--VIEW: a virtual table that shows data without storing it physically


--DDL(Data Definition Language): A set of commands that allows us to define and manage the structure of a database.

--VIEW: Virtual table based on the result set of a query,without storing the data in the database
--CENTRAL QUERY LOGIC: Store central,complex query logic in the database for access by multiple queries, reducing 
--project complexity
--HIDE COMPLEXITY: Views can be used to hide the complexity of a database tables and offers to users more friendly
--and easy to consume objects
--SECURITY: Views can be used to enforce security and protect sensitive data, by hiding columns and rows from tables

WITH CTE_Monthly_Summary AS(
	SELECT 
	DATETRUNC(month,OrderDate) OrderMonth,
	SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
)
SELECT 
OrderMonth,
TotalSales,
SUM(Total_Sales) OVER (ORDER BY OrderMonth) AS Runnnign_Total
FROM CTE_Monthly_Summary


CREATE VIEW V_MOnthly_Summary AS (
	SELECT 
	DATETRUNC(month,OrderDate) OrderMonth,
	SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
	)

	DROP VIEW V_MOnthly_Summary

