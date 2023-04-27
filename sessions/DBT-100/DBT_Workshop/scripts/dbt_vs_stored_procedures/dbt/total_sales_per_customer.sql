SELECT
    CustomerID,
    SUM(SalesAmount) AS TotalSales
FROM {{ ref('orders') }}
GROUP BY CustomerID



