CREATE PROCEDURE usp_CalculateTotalSales
AS
BEGIN
    IF OBJECT_ID('TotalSalesPerCustomer') IS NOT NULL
        DROP TABLE TotalSalesPerCustomer;

    CREATE TABLE TotalSalesPerCustomer (
        CustomerID INT,
        TotalSales DECIMAL(18, 2)
    );

    INSERT INTO TotalSalesPerCustomer (CustomerID, TotalSales)
    SELECT CustomerID, SUM(SalesAmount) AS TotalSales
    FROM Orders
    GROUP BY CustomerID;
END;
GO
