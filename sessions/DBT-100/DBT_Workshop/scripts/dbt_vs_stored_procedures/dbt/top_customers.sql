WITH top_customers AS (
    SELECT
        CustomerID,
        TotalSales,
        ROW_NUMBER() OVER (ORDER BY TotalSales DESC) AS RowNum
    FROM {{ ref('total_sales_per_customer') }}
)

SELECT
    CustomerID,
    TotalSales
FROM top_customers
WHERE RowNum <= 5


