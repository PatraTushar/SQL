--Total Customers from Germany:2
--Average Score from Germany:425

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) ='USA'
AS
	BEGIN
	BEGIN TRY

		DECLARE @TotalCustomers INT,@AvgScore FLOAT;
		-- ================================
		-- Step 1: Prepare and cleanup Data
		-- ================================
		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country=@Country)
		BEGIN
		PRINT('Updating NULL Score to 0');
		UPDATE Sales.Customers
		SET Score=0
		WHERE Score IS NULL AND Country= @Country;
		END

		ELSE 
		BEGIN
		PRINT('No NULL Scores Found')
		END;

		-- ================================
		-- Step 2: Generating Reports
		-- ================================
		--Calculate Total Customers and Average Score for Specific Country 
		
		SELECT
		@TotalCustomers= COUNT(*),
		@AvgScore= AVG(Score) 
		FROM Sales.Customers
		WHERE Country =@Country;

		PRINT 'Total Customers from ' + @Country +':' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score from ' + @Country+ ':' +  CAST(@AvgScore AS NVARCHAR);


		--Calculate  Total Number Of Orders and Total Sales for Specific Country
		SELECT
		COUNT(OrderID) TotalOrders,
		SUM(Sales) TotalSales
		FROM Sales.Orders o
		JOIN Sales.Customers c
		ON c.CustomerID=o.CustomerID
		WHERE c.Country=@country;

	END TRY
	BEGIN CATCH
	--- ================================
	--- Error Handling
	--- =================================
	PRINT('An error occuresd');
	PRINT('Error Message:'+ERROR_MESSAGE());
	PRINT('Error Number:' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Error Line:' +CAST(ERROR_LINE() AS NVARCHAR));
	PRINT('Error Procedure'+ ERROR_PROCEDURE());
	END CATCH
	END
GO


EXEC GetCustomerSummary

EXEC GetCustomerSummary @Country='Germany'

EXEC GetCustomerSummary @Country='USA'

DROP PROCEDURE GetCustomerSummaryGermany



