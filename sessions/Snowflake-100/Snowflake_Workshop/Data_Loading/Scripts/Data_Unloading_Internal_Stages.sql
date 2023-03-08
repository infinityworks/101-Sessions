
--Create a Named Stage with the file format you prefer
CREATE OR REPLACE STAGE PRODUCT_UNLOAD_STAGE
    FILE_FORMAT = 'CSV_WITH_PIPE';

--List the file format to verify it is empty
LIST @PRODUCT_UNLOAD_STAGE;

--Copy the contents into the Internal stage
COPY INTO @PRODUCT_UNLOAD_STAGE/unload/ FROM PRODUCTS;

--Verify if the file has been loaded into the stage 
LIST @PRODUCT_UNLOAD_STAGE;

--Login to snowflake using "snowsql -a <snowflake-account> -u <username>"
--Use the below command to get the contents of the stage into your local system

GET @product_unload_stage/unload/data_0_0_0.csv.gz file://Documents;