/*----------------Loading using External Stage Hands-on----------------
1) Creating External Named Stage
2) Creating File Format
3) Loading using External Named Stage
----------------------------------------------*/
-- Set context
USE WAREHOUSE COMPUTE_WH;
USE DATABASE MANAGE_DB;
USE ROLE ACCOUNTADMIN;

-- Create Schema
CREATE SCHEMA FILE_FORMATS;
CREATE OR REPLACE SCHEMA EXTERNAL_STAGES;

-- Create Table
CREATE TABLE DEMO_DB.DEMO_SCHEMA.PRODUCTS (
	PRODUCT_ID NUMBER(10,0) NOT NULL,
	PRODUCT_NAME VARCHAR(256) NOT NULL,
	UNIT_PRICE NUMBER(10,2) NOT NULL,
	SUBCATEGORY_ID NUMBER(10,0) NOT NULL,
    FILENAME VARCHAR(256) NOT NULL
);

-- Create File Format
CREATE FILE FORMAT FILE_FORMATS.CSV_PIPE_DELIMITED
	TYPE = CSV
    FIELD_DELIMITER = '|'
    SKIP_HEADER = 1;

-- Create External Stage
CREATE OR REPLACE STAGE PRODUCT_STAGE
    URL = 'azure://snowflakeworkshop1804.blob.core.windows.net/snowflakeworkshop1804/load/products/'
    CREDENTIALS =(azure_sas_token='REPLACE_WITH_SAS_TOKEN_PROVIDED_BY_INSTRUCTOR')
    FILE_FORMAT = FILE_FORMATS.CSV_PIPE_DELIMITED;

--List files in stage
LIST @PRODUCT_STAGE;

--Creating Pattern to load Current Date file ( Stored Procedure can replace doing it here)
SET DATEVAR = (SELECT TO_VARCHAR(CURRENT_DATE(), 'yyyymmdd'));
SET Path =  (SELECT '.*products_'|| $DATEVAR || '.csv');
SELECT $Path;
--azure://snowflakeworkshop.blob.core.windows.net/snowflakeworkshopfiles/load/products/products_20230414.csv
--Loading into table using Copy command and using Pattern
COPY INTO DEMO_DB.DEMO_SCHEMA.PRODUCTS
FROM (SELECT $1, $2, $3, $4, metadata$filename from @PRODUCT_STAGE (PATTERN=>$Path));

-- Validating the data
SELECT * FROM DEMO_DB.DEMO_SCHEMA.PRODUCTS;
