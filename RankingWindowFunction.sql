--Rank the order based on their sales from highest to lowest

SELECT
orderID,
ProductID,
sales,
ROW_NUMBER() OVER (ORDER BY sales DESC) AS salesRankROW_NUMBER,
RANK() OVER (ORDER BY sales DESC) AS salesRankRANK,
DENSE_RANK() OVER (ORDER BY sales DESC) AS salesRankDENSE_RANK
FROM sales.orders

--Find the top highest sales for each product
SELECT *
FROM(
SELECT
OrderID,
ProductID,
sales,
ROW_NUMBER() OVER(PARTITION BY productID ORDER BY sales DESC) AS RankByProduct
FROM sales.Orders
)t WHERE RankByProduct=1

--Find the lowest 2 customers based on their total sales
SELECT *
FROM(
SELECT
CustomerID,
SUM(sales) AS TotalSales,
ROW_NUMBER() OVER(ORDER BY SUM(sales) ASC ) AS Ranks
FROM Sales.Orders
GROUP BY CustomerID
)t WHERE Ranks <= 2


--Assign unique IDs to the rows of the Orders Archieve table 
SELECT 
ROW_NUMBER() OVER(ORDER BY orderID,orderDate) AS uniqueIDs,
*
FROM Sales.OrdersArchive


--Identify duplicate rows in the table orders Archieve and return a clean result without any duplicates
SELECT *
FROM
(
SELECT 
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY creationTime DESC) AS rn,
*
FROM sales.OrdersArchive
)t WHERE rn=1

--NTILE
SELECT
OrderID,
Sales,
NTILE(1) OVER(ORDER BY sales DESC) AS OneBucket,
NTILE(2) OVER(ORDER BY sales DESC) AS TwoBucket,
NTILE(3) OVER(ORDER BY sales DESC) AS ThreeBucket,
NTILE(4) OVER(ORDER BY sales DESC) AS FourBucket
FROM Sales.Orders


--Segment all orders into 3 categories high,medium and low sales
SELECT
*,
CASE WHEN Buckets=1 THEN 'High'
     WHEN Buckets=2 THEN 'Medium'
	 WHEN Buckets=3 THEN 'Low'
END AS salesSegmentation
FROM(
SELECT
OrderID,
Sales,
NTILE(3) OVER(ORDER BY sales) AS Buckets
FROM sales.Orders
)t

--In order to export the data divides the order into 2 groups
SELECT
NTILE(2) OVER(ORDER BY OrderID) AS Buckets,
*
FROM sales.Orders

--Find the product that falls within the highest 40% of prices
SELECT
*,
CONCAT(DistRank*100,'%') AS DistRankPerc
FROM
(
SELECT
Product,
Price,
CUME_DIST() OVER(ORDER BY Price DESC) AS DistRank 
FROM sales.Products
)t
WHERE DistRank<=0.4 



