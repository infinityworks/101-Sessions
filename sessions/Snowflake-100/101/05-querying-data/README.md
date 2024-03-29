# Viewing data

To view and query data, swap back to a worksheet if you're not there already.

The most basic query is to retrieve everything from our table:

    SELECT * FROM RAW_DATA.SALES.TRANSACTIONS;

When you're just looking to see what data is in a table it is good practice to limit how many rows are returned in your query. This stops the database from having to retreive every row and display it, which can be very costly if there are millions or even billions of rows. We do this by adding a `LIMIT` clause to the end of our query.

    SELECT * FROM RAW_DATA.SALES.TRANSACTIONS LIMIT 10;


Snowflake can query JSON and other semi-structured data from within a VARIANT column too:

    SELECT PAYLOAD:"PRODUCTS_VIEWED" FROM RAW_DATA.SALES.TRANSACTIONS;

You can use a colon to traverse the keys in the JSON to get to the required element, in this case `"PRODUCTS_VIEWED"`.


## Unpacking lists and arrays in data

We can explode lists within a nested JSON structure in a VARIANT field to flatten the data into separate rows for easier analysis [[docs](https://docs.snowflake.com/en/sql-reference/functions/flatten.html)]


    SELECT
        PAYLOAD:CUSTOMER_ID::VARCHAR AS customer_id,
        FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS product_id,
        FLATTENED_DATA.VALUE:PRICE::NUMBER AS price,
        PAYLOAD:DATE_OF_SESSION::TIMESTAMP AS DATE_OF_SESSION
    FROM
        RAW_DATA.SALES.TRANSACTIONS AS TRANSACTIONS,
        LATERAL FLATTEN(input => TRANSACTIONS.PAYLOAD, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA;


This query specifies the database and schema where the table lives; if you do not specify them you must set the context as seen previously with:

    USE DATABASE RAW_DATA;
    USE SCHEMA SALES;

We can find insights like the most popular products sold:

    SELECT
        FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS PRODUCT_ID,
        SUM(1) AS FREQUENCY
    FROM
        TRANSACTIONS AS TRANSACTIONS,
        LATERAL FLATTEN(input => TRANSACTIONS.PAYLOAD, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA
    GROUP BY
        FLATTENED_DATA.VALUE:PRODUCT_ID
    ORDER BY
        FREQUENCY DESC;

## Creating a view [[docs](https://docs.snowflake.com/en/user-guide/views-introduction.html)]

Useful queries can be saved as a view, this stores the data manipulation language (the sql statement or DML) in a table-like object so we can recall the data on the fly - quickly.

The physical data is not stored again but instead acts as a handy shortcut to run complex queries.

We will create this view using the SYSADMIN role.

    CREATE OR REPLACE VIEW RAW_DATA.SALES.TOP_10_VIEWED_PRODUCTS AS
    (
        SELECT
            FLATTENED_DATA.VALUE:PRODUCT_ID::VARCHAR AS PRODUCT_ID,
            SUM(1) AS FREQUENCY
        FROM
            RAW_DATA.SALES.TRANSACTIONS AS TRANSACTIONS,
            LATERAL FLATTEN(input => TRANSACTIONS.PAYLOAD, path => 'PRODUCTS_VIEWED') AS FLATTENED_DATA
        GROUP BY
            FLATTENED_DATA.VALUE:PRODUCT_ID
        ORDER BY
            FREQUENCY DESC
        LIMIT 10
    ); 

To run the view, use:

    SELECT * FROM RAW_DATA.SALES.TOP_10_VIEWED_PRODUCTS;

The useful thing about Views is that they are automatically up to date as their source data changes. So as more transactions get loaded in the future, the `"TOP_10_VIEWS_PRODUCTS"` view will always contain the top 10 most viewed products.

>### A note on database design
>
>It would be a better design to create a new database for the `"TOP_10_VIEWS_PRODUCTS"` view to go in, rather than it going in the RAW_DATA database.
>
>This is a principle called Seaparation of Concerns, where each component has a defined role to play. The RAW_DATA database should only contain raw, untouched data. By adding logic to find the 10 most viewed products, this is no longer raw data and so should sit in a separate database.
>
>But for the purposes of simplicity in this introduction we'll create it in RAW_DATA.

## Granting Permissions on this view and creating a reporting warehouse

If we were to log in as JohnnyLawrence, they only have the DATA_CONSUMER role, and therefore would not be able to see this useful view that we've created as a SYSADMIN. We need to explicity grant permissions to the DATA_CONSUMER role so they can see this view, and we also need to grant them compute power though a virtual warehouse to run their queries.

We could use the same warehouse we have used for loading the data across both roles, but this can become a challenge when you're increasing the scale or your data warehouse. Queries get queued when you have stretched a warehouse to it's limits, and you don't want the CEO waiting on their report to load because you're trying to load a massive JSON file at the same time!

### Creating a new warehouse

    USE ROLE SYSADMIN;
    CREATE OR REPLACE WAREHOUSE Reporting_WH WAREHOUSE_SIZE = 'Medium';
    GRANT USAGE ON WAREHOUSE Reporting_WH TO ROLE DATA_CONSUMER;

### Grant Permissions

    GRANT USAGE ON SCHEMA RAW_DATA.SALES TO ROLE DATA_CONSUMER;
    GRANT SELECT ON VIEW RAW_DATA.SALES.TOP_10_VIEWED_PRODUCTS TO ROLE DATA_CONSUMER;

If we now swap to the DATA_CONSUMER role

    USE ROLE DATA_CONSUMER;

You can see they can access the nice, business friendly view, but are blocked when trying to access the raw data.

    SELECT * FROM RAW_DATA.SALES.TOP_10_VIEWED_PRODUCTS;
    SELECT * FROM RAW_DATA.SALES.TRANSACTIONS;
