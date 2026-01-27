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