# Querying data

Swap back to the console in browser to make use of the GUI's rendering.

The most basic query is to retrieve everything:

    SELECT * FROM "RAW_DATA"."SALES"."TRANSACTIONS"

Snowflake can query semi-structured data too:

    SELECT RAW_DATA:"basket" FROM "RAW_DATA"."SALES"."TRANSACTIONS"

**Note:** `basket` is lowercase and so we must quote this key when querying.

We can explode lists within each row to flatten the data for analysis [[docs](https://docs.snowflake.com/en/sql-reference/functions/flatten.html)]

    SELECT RAW_DATA:"customer_id" AS "customer_id",
        flattened_data.VALUE:"product_id" AS "product_id",
        flattened_data.VALUE:"price" AS "price",
        RAW_DATA:"date_of_purchase" AS "date_of_purchase"

    FROM "RAW_DATA"."SALES"."TRANSACTIONS" AS TRANSACTIONS,
        lateral flatten(input => TRANSACTIONS.RAW_DATA, path => 'basket') AS flattened_data  
