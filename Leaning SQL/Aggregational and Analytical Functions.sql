--Aggregational and Analytical Functions
USE MyDatabase
SELECT
COUNT(*) AS Count,
SUM(sales) AS Sum,
MAX(sales) AS Max

FROM orders
GROUP BY customer_id

--WINDOW FUNCTIONS
--Performs calculations	on a specific subset of data, without losing the level of details of rows	
--1 can only be used in SELECT or ORDER BY clauses
--2 nesting window functions is not allowed
--3 SQL execute WINDOW functions after where clause
--4 window functions can be used together with GROUP BY


--Window funtions returns a result for each rows
USE SalesDB
SELECT 
SUM(Sales) As Sales_Product
FROM Sales.Orders
GROUP BY ProductID

SELECT 
SUM(Sales) OVER(PARTITION BY ProductID) AS Window_sum
FROM Sales.Orders

SELECT 
OrderID,
OrderDate,
ProductID,
Sales,
SUM(Sales) OVER() Total_Sales,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct,
SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) TotalSalesByProduct
FROM Sales.Orders

--RANK() will enumerate the number of rows of a subtable in order defined by the ORDER BY

SELECT OrderID,
OrderDate,
Sales,
RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders

--FRAME Clause will reduces the space of result, have to be preceed with ORDER BY

SUM(Sales)	OVER(ORDER BY Month ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING)

SUM(Sales)	OVER(ORDER BY Month ROWS BETWEEN  CURRENT ROW AND UNBOUNDED FOLLOWING)


SELECT 
OrderId,
OrderDate,
OrderStatus,
ProductID,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus) Total_Sales
FROM Sales.Orders

--Use GROUP BY + WINDOW FUNCTION in the same query, only if the same column is used

SELECT 
CustomerID,
SUM(Sales) Total_Sales,
RANK() OVER(ORDER BY SUM(Sales) DESC) Ranked_Sales
FROM Sales.Orders
GROUP BY CustomerID

--WINDOW AGGREGATE FUNCTIONS

COUNT(*) OVER(PARTITION BY Product)

--Duplicates
SELECT 
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.Orders

--Comparison Analyser: Compare the current value and aggregate value of window functions

SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER() * 100,2) ContributionToTotal
FROM Sales.Orders

--SUBQUERY: Used to filter the previous select query
SELECT *
FROM (
	SELECT *,
	MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees) AS t
WHERE Salary = HighestSalary

--RUNNING E ROLLING TOTAL: Tracking current sales with target sales	and trand analysis, 
--they aggregate sequence of members, and the aggregation is updated each time a new member is addes
--RUNNING TOTAL:Aggregate all value from the beginning up to the current without dropping off older data
--ROLLING TOTAL:Aggregate all values within a fixed time window

SELECT
OrderID,
ProductID,
OrderDate,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders

--RANK FUNCTIONS are used for ranking the rows of a table, the order by is required for the calculation,
--partition by is optional and frame clause are not allowed

--ROW_NUMBER() Assign a unique number to each in a window
--RANK() will assign a rank to each rows, handling the ties, leaving gaps in the ranking
--DENSE_RANK() will assing a rank to each rows, handling ties, without leaving gaps in the process 

SELECT 
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales) AS Sales_Rank,
RANK() OVER(ORDER BY Sales) AS Sales_Ranking,
DENSE_RANK() OVER(ORDER BY Sales) AS Sales_Ranking_Dense
FROM Sales.Orders


--

SELECT *
FROM(
	SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales) AS Sales_Rank
	FROM Sales.Orders) AS t 
WHERE Sales_Rank = 1


--

SELECT *
FROM(
	SELECT 
	CustomerID,
	SUM(Sales) TotalSales,
	ROW_NUMBER() OVER( ORDER BY SUM(Sales)) AS Rank_Customer
	FROM Sales.Orders
	GROUP BY CustomerID) as t
WHERE Rank_Customer <= 2

--

SELECT 
ROW_NUMBER() OVER(ORDER BY OrderId) UniqueID,
*
FROM Sales.OrdersArchive

--
SELECT * 
	FROM(
	SELECT *,	
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn
	FROM Sales.OrdersArchive) AS t
WHERE rn = 1


--NTILE() will devides the rows into a specified number of appoximately equal groups

SELECT
OrderID,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC) Bucket
FROM Sales.Orders

---

SELECT
*,
NTILE(2) OVER(ORDER BY OrderID) Bucket
FROM Sales.Orders

--CUME_DIST() will devides the rows taking the position number of the row / the total number of rows

CUME_DIST() OVER (ORDER BY Sales DESC)

--PERCENT_RANK() will calculate the relative position of each row

PERCENT_RANK() OVER (ORDER BY Sales DESC)

--WINDOW VALUE FUNCTION

--LEAD(Expression, Offset, Default Value) will access a value from the next row within a window	
--LAG()  will access a value from the previuos row within a window


--TIME SERIES ANALYSIS
SELECT 
MONTH(OrderDate) OrderMonth,
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviusMonth
FROM Sales.Orders
GROUP BY
MONTH(OrderDate)

--DATEDIFF() will calculate the difference between two date values
SELECT
CustomerID,
AVG(DateDifference) AvgDays
FROM(
	SELECT 
	OrderID,
	CustomerId,
	OrderDate CurrentOrder,
	LEAD(OrderDate) OVER(PARTITION BY CustomerId ORDER BY OrderDate) NextOrder,
	DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerId ORDER BY OrderDate)) DateDifference
	FROM Sales.Orders
	)t
GROUP BY CustomerID


--FIRST_VALUE() will give access to a value from the first row within a window
--LAST_VALUE() will give access to a value from the last row within a window

SELECT 
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) Lowest_sales,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) Highest_sales
FROM Sales.Orders
