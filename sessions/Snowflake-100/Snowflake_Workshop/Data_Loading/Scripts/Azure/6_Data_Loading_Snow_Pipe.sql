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

-- Create Notification Integration
CREATE OR REPLACE NOTIFICATION INTEGRATION AZURE_SNOWPIPE_EVENT
  ENABLED = TRUE
  TYPE = QUEUE
  NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
  AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://snowflakeworkshop1804.queue.core.windows.net/snowflakeworkshop'
  AZURE_TENANT_ID = 'a62dc8e6-7e5d-4434-bb71-b01128f526df';

-- Check Integrations
SHOW INTEGRATIONS;

-- DESC NOTIFICATION INTEGRATION
DESC NOTIFICATION INTEGRATION AZURE_SNOWPIPE_EVENT;

--Create External Stage
CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE
    URL = 'azure://snowflakeworkshop1804.blob.core.windows.net/snowflakeworkshop1804'
    CREDENTIALS =(azure_sas_token='REPLACE_WITH_SAS_TOKEN_PROVIDED_BY_INSTRUCTOR')
    FILE_FORMAT = MANAGE_DB.FILE_FORMATS.JSON_FILE;

-- Files in Stage
LIST @MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE;

--Create SnowPipe
CREATE OR REPLACE PIPE MANAGE_DB.PIPES.SALES_PIPE
    AUTO_INGEST = TRUE
    INTEGRATION = AZURE_SNOWPIPE_EVENT
    AS
    COPY INTO DEMO_DB.DEMO_SCHEMA.SALES
    FROM (SELECT $1, metadata$filename from @MANAGE_DB.EXTERNAL_STAGES.SALES_STAGE);

-- Show pipe
SHOW PIPES;

-- Refresh Pipe for inserting existing stage files into table
-- ALTER PIPE MANAGE_DB.PIPES.SALES_PIPE REFRESH;

--Get SnowPipe Status details
SELECT SYSTEM$PIPE_STATUS('SALES_PIPE');

--Validate the data in the table
SELECT * FROM DEMO_DB.DEMO_SCHEMA.SALES;

-- To see the error file loading
-- SELECT * FROM
-- table(information_schema.copy_history(table_name=>'table_name', start_time=> dateadd(hours,-1, current_timestamp())))
