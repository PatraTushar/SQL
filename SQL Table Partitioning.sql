--Step 1 -> Create A Partition Function

CREATE PARTITION FUNCTION PartitionByYear(DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31','2024-12-31','2025-12-31')

-- Query List All Existing Partition Function
SELECT
    name,
	function_id,
	type,
	type_desc,
	Boundary_Value_on_right
	FROM sys.partition_functions

	--Step 2 -> Create File Groups
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2024;
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2025;
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2026;

	ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023;
	ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2024;
	ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2025;
	ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2026;

	--Query list all existing file groups
	SELECT *
	FROM 
	sys.filegroups
	WHERE type='FG'

	--Step 3 -> Add .ndf Files to Each Filegroup

	ALTER DATABASE SalesDB ADD FILE
	(
	NAME= P_2023, --Logical Name
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2023.ndf'
	)TO FILEGROUP FG_2023;

	ALTER DATABASE SalesDB ADD FILE
	(
	NAME= P_2024, --Logical Name
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2024.ndf'
	)TO FILEGROUP FG_2024;


	ALTER DATABASE SalesDB ADD FILE
	(
	NAME= P_2025, --Logical Name
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2025.ndf'
	)TO FILEGROUP FG_2025;

	ALTER DATABASE SalesDB ADD FILE
	(
	NAME= P_2026, --Logical Name
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2026.ndf'
	)TO FILEGROUP FG_2026;

	SELECT
	fg.name AS FileGroupName,
	mf.name As LogicalFileName,
	mf.physical_name AS physicalFilePath,
	mf.size / 128 AS SizeInMB

	FROM 
	sys.filegroups fg
	JOIN
	sys.master_files mf ON fg.data_space_id = mf.data_space_id
	WHERE 
	mf.database_id=DB_ID('SalesDB');

	--Step 4 -> Create artition Scheme

	CREATE PARTITION SCHEME SchemePartitionByYear
	AS PARTITION PartitionByYear
	TO (FG_2023,FG_2024,FG_2025,FG_2026)

	--Query lists all partition Scheme
	SELECT
	ps.name AS PartitionShemeName,
	pf.name AS PartitionFunctionName,
	ds.destination_id AS PartitionNumber,
	fg.name AS FilegroupName
	FROM sys.partition_schemes ps
	JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
	JOIN sys.destination_data_spaces ds ON ps.data_space_id=ds.partition_scheme_id
	JOIN sys.filegroups fg ON ds.data_space_id=fg.data_space_id

	--Step 5 -> Create Partitioned Table

	CREATE TABLE Sales.Orders_Partitioned
	(
	OrderId INT,
	OrderDate DATE,
	Sales INT
	) ON SchemePartitionByYear (OrderDate)

	--Step 6 -> Insert Data into Partitioned Table

	INSERT INTO Sales.Orders_Partitioned VALUES(1,'2023-05-15',100);
	INSERT INTO Sales.Orders_Partitioned VALUES(1,'2024-07-20',50);
	INSERT INTO Sales.Orders_Partitioned VALUES(1,'2025-12-31',50);
	INSERT INTO Sales.Orders_Partitioned VALUES(1,'2026-01-01',100);


	SELECT * FROM Sales.Orders_Partitioned

	SELECT 
	p.partition_number AS PartitionNumber,
	f.name AS PartitionFilegroup,
	p.rows AS NumberOfRows
	FROM sys.partitions p
	JOIN sys.destination_data_spaces dds ON p.partition_number=dds.destination_id
	JOIN sys.filegroups f ON dds.data_space_id=f.data_space_id 
	WHERE OBJECT_NAME(p.object_id)='Orders_Partitioned';
	



	-- Perfomance Of Partitioned Table

	SELECT *
	INTO Sales.Orders_NoPartitioned
	FROM Sales.Orders_Partitioned

	SELECT *
	FROM Sales.Orders_NoPartitioned
	WHERE OrderDate='2026-01-01'

	SELECT *
	FROM Sales.Orders_Partitioned
	WHERE OrderDate='2026-01-01'




	 

