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

-- use Storage Integration created in external loading stage ( s3_int)

-- Check Integrations
SHOW INTEGRATIONS;

--Create External Stage
CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE
    STORAGE_INTEGRATION=s3_int
    URL = 's3://<bucket name>/<folder name if any>/'
    FILE_FORMAT = MANAGE_DB.FILE_FORMATS.JSON_FILE;

-- Files in Stage
LIST @MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE;

--Create SnowPipe
CREATE OR REPLACE PIPE MANAGE_DB.PIPES.SALES_PIPE
    AUTO_INGEST = TRUE
    AS
    COPY INTO DEMO_DB.DEMO_SCHEMA.SALES
    FROM (SELECT $1, metadata$filename from @MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE);

-- Show pipe
SHOW PIPES;
-- Now we need to add the event notification on the S3 bucket

-- Refresh Pipe for inserting existing stage files into table
ALTER PIPE MANAGE_DB.PIPES.SALES_PIPE REFRESH;

--Get SnowPipe Status details
SELECT SYSTEM$PIPE_STATUS('SALES_PIPE');

--Validate the data in the table
SELECT * FROM DEMO_DB.DEMO_SCHEMA.SALES;

-- To see the error file loading
-- SELECT * FROM
-- table(information_schema.copy_history(table_name=>'table_name', start_time=> dateadd(hours,-1, current_timestamp())))