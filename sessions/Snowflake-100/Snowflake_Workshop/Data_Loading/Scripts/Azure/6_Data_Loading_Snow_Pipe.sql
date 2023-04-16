/*----------------Snow Pipe Hands-on----------------
1) Create Snow Pipe
2) Understand SnowPipe
----------------------------------------------*/
-- Set context
USE WAREHOUSE COMPUTE_WH;
USE DATABASE MANAGE_DB;

-- Create Schema
CREATE SCHEMA PIPES;

--Create JSON File Format
CREATE FILE FORMAT MANAGE_DB.FILE_FORMATS.JSON_FILE
    TYPE = JSON
    STRIP_OUTER_ARRAY = TRUE;

--Create Sales Table
CREATE OR REPLACE TABLE DEMO_DB.DEMO_SCHEMA.SALES (
    SALES_ITEM VARIANT,
    FILENAME VARCHAR(256)
    );

--Create External Stage
CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE
    URL = 'azure://snowflakeworkshop.blob.core.windows.net/snowflakeworkshopfiles/load/sales/'
    CREDENTIALS =(azure_sas_token='REPLACE_WITH_SAS_TOKEN_PROVIDED_BY_INSTRUCTOR')
    FILE_FORMAT = MANAGE_DB.FILE_FORMATS.JSON_FILE;

--Create SnowPipe
CREATE OR REPLACE PIPE MANAGE_DB.PIPES.SALES_PIPE
    AUTO_INGEST=FALSE
    AS
    COPY INTO DEMO_DB.DEMO_SCHEMA.SALES
    FROM (SELECT $1, metadata$filename from @MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE);

-- Show pipe
SHOW PIPES;

--Get SnowPipe Status details
SELECT SYSTEM$PIPE_STATUS('SALES_PIPE');

--Validate the data in the table
SELECT * FROM DEMO_DB.DEMO_SCHEMA.SALES;
