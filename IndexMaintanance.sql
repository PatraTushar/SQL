
-- 1-> Monitor Index Usage

-- List all index on a specific table

sp_helpindex 'Sales.DBCustomers'

-- Monitoring index usage
SELECT 
tbl.name AS TableName,
idx.name AS IndexName,
idx.type_desc AS IndexType,
idx.is_primary_key AS IsPrimaryKey,
idx.is_unique AS IsUnique,
idx.is_disabled AS IsDisabled,
s.user_seeks AS UserSeeks,
s.user_scans AS UserScans,
s.user_lookups AS UserLookups,
s.user_updates AS UserUpdates,
s.last_user_seek AS UserSeek,
s.last_user_scan AS UserScan,
COALESCE(s.last_user_seek,s.last_user_scan) AS LastUpdate
FROM sys.indexes AS idx
JOIN sys.tables AS tbl
ON idx.object_id = tbl.object_id
LEFT JOIN Sys.dm_db_index_usage_stats AS s
ON s.object_id = idx.object_id
AND s.index_id = idx.index_id
ORDER BY tbl.name,idx.name

SELECT *
FROM Sys.dm_db_index_usage_stats

-- 2-> Monitor Missing Indexes

SELECT 
    fs.SalesOrderNumber,
	dp.EnglishProductName,
	dp.color
FROM FactInternetSales fs
INNER JOIN DimProduct dp
ON fs.ProductKey = dp.ProductKey
WHERE dp.Color='Black'
AND fs.OrderDateKey BETWEEN 20101229 AND 20101231


SELECT * FROM sys.dm_db_missing_index_details

-- 3-> Monitor Missing Indexes

SELECT
tbl.name AS TableName,
col.name As IndexColumn,
idx.name AS IndexName,
idx.type_desc AS IndexType,
COUNT(*) OVER (PARTITION BY tbl.name,col.name) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic ON idx.object_id=ic.object_id AND idx.index_id =ic.index_id
JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id =col.column_id
ORDER BY ColumnCount DESC

-- 4-> Update Statistics


SELECT
SCHEMA_NAME(t.schema_id) AS SchemaName,
t.name AS TableName,
s.name AS StatisticName,
sp.last_updated AS LastUpdate,
DATEDIFF(day,sp.last_updated,GETDATE()) AS LastUpdateDate,
sp.rows AS 'Rows',
sp.modification_counter AS ModificationSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables t
ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id,s.stats_id) AS sp
ORDER BY
sp.modification_counter DESC

UPDATE STATISTICS Sales.DBCustomers

EXEC sp_updatestats

-- 5->Monitor Fragmentation
SELECT
tbl.name AS TableName,
idx.name AS IndexName,
s.avg_fragmentation_in_percent,
s.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'LIMITED') AS S
INNER JOIN sys.tables tbl
ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx
ON idx.object_id = S.object_id
AND idx.index_id = S.index_id
ORDER BY s.avg_fragmentation_in_percent DESC

ALTER INDEX idx_Customer_Country ON Sales.Customers REORGANIZE

ALTER INDEX idx_Customer_Country ON Sales.Customers REORGANIZE





