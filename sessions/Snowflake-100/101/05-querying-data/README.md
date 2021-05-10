# Viewing data

To view and query data, swap back to a worksheet if you're not there already.

The most basic query is to retrieve everything from our table:

    SELECT * FROM RAW_DATA.SALES.TRANSACTIONS;

Snowflake can query JSON and other semi-structured data from within a VARIANT column too:

    SELECT RAW_DATA:"basket" FROM RAW_DATA.SALES.TRANSACTIONS

You can use a colon to traverse the keys in the JSON to get to the required element, in this case `"basket"`.

>**Note:** `basket` is lowercase and so we must quote this key when querying.

## Unpacking lists and arrays in data

We can explode lists within a nested JSON structure in a VARIANT field to flatten the data into separate rows for easier analysis [[docs](https://docs.snowflake.com/en/sql-reference/functions/flatten.html)]


    SELECT
        RAW_DATA:CUSTOMER_ID::VARCHAR AS customer_id,
        FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS product_id,
        FLATTENED_DATA.VALUE:PRICE::NUMBER AS price,
        RAW_DATA:DATE_OF_SESSION::TIMESTAMP AS DATE_OF_SESSION
    FROM
        RAW_DATA.SALES.TRANSACTIONS AS TRANSACTIONS,
        LATERAL FLATTEN(input => TRANSACTIONS.RAW_DATA, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA;


This query specifies the database and schema where the table lives; if you do not specify them you must set the context as seen previously with:

    USE DATABASE RAW_DATA;
    USE SCHEMA SALES;

We can find insights like the most popular products sold:

    SELECT FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS PRODUCT_ID,
        SUM(1) AS FREQUENCY
    FROM RAW_DATA.SALES.TRANSACTIONS AS TRANSACTIONS,
        LATERAL FLATTEN(input => TRANSACTIONS.RAW_DATA, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA
    GROUP BY FLATTENED_DATA.VALUE:PRODUCT_ID
    ORDER BY FREQUENCY DESC;

## Creating a view [[docs](https://docs.snowflake.com/en/user-guide/views-introduction.html)]

Useful queries can be saved as a view, this stores the data manipulation language (the sql statement or DML) in a table-like object so we can recall the data on the fly - quickly.

The physical data is not stored again but instead acts as a handy shortcut to run complex queries.

    CREATE OR REPLACE VIEW RAW_DATA.SALES.TOP_10_VIEWED_PRODUCTS AS
    (
      SELECT FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS PRODUCT_ID,
          SUM(1) AS FREQUENCY
      FROM RAW_DATA.SALES.TRANSACTIONS AS TRANSACTIONS,
          LATERAL FLATTEN(input => TRANSACTIONS.RAW_DATA, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA
      GROUP BY FLATTENED_DATA.VALUE:PRODUCT_ID
      ORDER BY FREQUENCY DESC
      LIMIT 10
    );

To run the view, use:

    SELECT * FROM RAW_DATA.SALES.TOP_10_VIEWED_PRODUCTS;
