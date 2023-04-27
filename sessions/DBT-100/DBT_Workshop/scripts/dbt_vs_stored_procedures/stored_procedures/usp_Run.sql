BEGIN TRY
    -- Run the first stored procedure
    EXEC usp_CalculateTotalSales;

    -- Check if CustomerID is unique and not null
    DECLARE @UniqueCustomerIDCount INT;
    DECLARE @TotalCustomerIDCount INT;

    SELECT @UniqueCustomerIDCount = COUNT(DISTINCT CustomerID), @TotalCustomerIDCount = COUNT(CustomerID)
    FROM TotalSalesPerCustomer
    WHERE CustomerID IS NOT NULL;

    IF @UniqueCustomerIDCount = @TotalCustomerIDCount
    BEGIN
        -- Run the second stored procedure
        EXEC usp_CalculateTopCustomers;
    END
    ELSE
    BEGIN
        PRINT 'CustomerID is not unique or contains null values. The second stored procedure will not be executed.';
    END;


