CREATE PROCEDURE usp_CalculateTopCustomers
AS
BEGIN
    IF OBJECT_ID('TopCustomers') IS NOT NULL
        DROP TABLE TopCustomers;

    CREATE TABLE TopCustomers (
        CustomerID INT,
        TotalSales DECIMAL(18, 2)
    );

    INSERT INTO TopCustomers (CustomerID, TotalSales)
    SELECT TOP 5 CustomerID, TotalSales
    FROM TotalSalesPerCustomer
    ORDER BY TotalSales DESC;
END;
GO

