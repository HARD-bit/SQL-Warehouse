--STRING FUNTIONS

--CONCAT combines multiple strings value into one
--LOWER/UPPER trasform a string into the selected format

USE MyDatabase
SELECT first_name, country,
CONCAT(first_name, country) AS mixed
FROM customers

--TRIM removes the empty spaces
--REPLACE replace specific character with a new character

SELECT 
'123-456-678'AS phone,
REPLACE('123-456-678','-','') AS clean_phone

--LEN will count the number of element of a string
--LEFT/RIGHT will select only the specified number of element from the beginning or the end of a string
--SUBSTRING extracts a part of a string at a specified position	 


--NUMBERS FUNCTIONS

--ROUND mantains the selected digits after 0 in a number
--ABS converts the number in its absolute version
SELECT	3.5,
ROUND(3.5,0) AS rounder

--DATE & TIME FUNTIONS

USE SalesDB
SELECT OrderID,
OrderDate,
ShipDate,
CreationTime,
GETDATE() AS TODAY
FROM Sales.Orders

--GET DATE will returns the current date and time when the query is executed
--DAY/MONTH/YEAR will return the day, month and year of a specified date

--DATEPART() returns a specific part of a day as a number, its more specific (hour,quarter,week..)
--DATENAME() returns a specific part of a day as a string(weekday...)
--DATETRUNC() returns only a specific part of the data type element, resetting to 0 the excluded part(year,day,minute...)
--EOMONTH() returns the last day of the month of the considered date



--FORMAT AND CAST

--FORMAT is used for modifying the format of a specific element in a table, using the specifier function paramether


SELECT 
OrderID,
CreationTime,
FORMAT(CreationTime, 'dd') AS dd,
FORMAT(CreationTime, 'ddd') AS ddd,
FORMAT(CreationTime, 'dddd') AS dddd,
FORMAT(CreationTime, 'MM') AS MM,
FORMAT(CreationTime, 'MMM') AS MMM,
FORMAT(CreationTime, 'MMMM') AS MMMM,
FORMAT(CreationTime, 'MM-dd-yyyy') AS USA
FROM Sales.Orders 


--CONVERT() converts a date or time value to a different data type

SELECT 
CONVERT(INT, '123') AS [String to int convert],
CONVERT(DATE, '2025-08-20') AS [String to date convert],
CONVERT(DATE,CreationTime) AS [Datetime to date convert],
CONVERT(VARCHAR,CreationTime,32) AS [Datetime to varchar convert]
FROM Sales.Orders

--CAST(value AS data_type)

SELECT 
CAST ('123' AS INT) AS [string to int],
CAST (123 AS VARCHAR) AS [int to string],
CAST ('2025-08-20' AS DATE ) AS [string to date],
CreationTime,
CAST (CreationTime AS DATE) AS [Datetime to date]
FROM Sales.Orders

--CALCULATIONS	 

--DATEADD(part, interval, date) will adds or subtracts a specific time interval to/from a date
--DATEDIFF(part, start_date, end_date) will make the difference between dates

SELECT 
OrderID,
OrderDate,
DATEADD(year, 2, OrderDate)
FROM Sales.Orders

SELECT 
EmployeeID,
BirthDate,
DATEDIFF(year, BirthDate, GETDATE()) AS age
FROM Sales.Employees

--ISDATE() will check if a value is a date return 1 if true 0 if false


--NULL FUNCTIONS

--IS NULL(Value, replacement_value) will replace 'NULL' with a specified value
--COALESCE() will do the same as IS NULL but taking as input 2 option, the second will be activate if the first is a null
--(Slow but avaliable in every database)
USE SalesDB
SELECT
CustomerID,
Score,
AVG(Score) OVER() AvgScore,
AVG(COALESCE(Score, 0)) OVER() AvgScoreWithoutNull
FROM Sales.Customers



USE SalesDB
SELECT CustomerID,Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END AS Flag
FROM Sales.Customers

ORDER BY Flag,Score

--NULLIF() Compare two expressions and returns NULL if they are equal or the first one if different


--TRIM() removes unwanted leading and trailing  spaces from a string 


--CASE STATEMENT will evaluetes a list of conditions and return a value when the first condition is met,the data type of the results must be the same
--if the else is not specyfied, the alternative result will be a null

--USE CASES(Categorizing data,Mapping Values, Handling Nulls, Conditional Aggregations)

USE SalesDB

SELECT 
Category,
SUM(Sales) AS Total_Sales
FROM(
	SELECT
	OrderID,
	Sales,
	CASE 
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END AS Category
	FROM Sales.Orders
) AS t
GROUP BY Category
ORDER BY Total_Sales DESC


SELECT 
CustomerID,
LastName,
Score,
CASE 
	WHEN Score IS NULL THEN 0
	ELSE Score
END Score_Clean,
AVG(CASE 
	WHEN Score IS NULL THEN 0
	ELSE Score
END) OVER() Avg_Customer
FROM Sales.Customers



SELECT 
CustomerID,
SUM(CASE WHEN Sales > 30 THEN 1
	ELSE 0
	END) AS Total_Orders
	
FROM Sales.Orders
GROUP BY CustomerID