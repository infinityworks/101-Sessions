--In order to securely connect a AWS account with Snowflake AWS account we need to create a storage integration for secure connections rather than passing the same while creating from roles

--To create the storage integration we need to setup something in AWS account. Details given in https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration


--Using Accountadmin role for creating a storage integration
USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE STORAGE INTEGRATION s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::569781470788:role/snowflake-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://bala-snowflake-workshop-20230307/');

-- This step is needed for updating the role with the user and external id of the storage integration
DESC INTEGRATION S3_INT;

USE SCHEMA RAW.RETAIL;

-- Lets use this file format since the file has data separated with Pipes for this example
CREATE FILE FORMAT CSV_WITH_PIPE 
	TYPE = CSV
    FIELD_DELIMITER = '|'
    SKIP_HEADER = 1;

-- Creating the stage based on Storage Integration
CREATE OR REPLACE STAGE product_stage
  STORAGE_INTEGRATION = s3_int
  URL = 's3://bala-snowflake-workshop-20230307/Products/'
  FILE_FORMAT = CSV_WITH_PIPE;

--Statement to check what all files are staged in External named stage which is created earlier

LIST @product_stage;

-- Below statements are required to load individual days file. This can be written as a logic using Snowflake stored procedure

SET DATEVAR = (SELECT TO_VARCHAR(CURRENT_DATE() -1, 'yyyymmdd'));

SET Path =  (SELECT '.*products_'|| $DATEVAR || '.csv');

SELECT $Path;


--If you see this copy statement we have written a SQL query to access stage and patterning the file name in order to copy individual files

COPY INTO PRODUCTS 
FROM (select $1, $2, $3, $4, metadata$filename from @PRODUCT_STAGE (PATTERN=>$Path));

--Loading current days file
SET DATEVAR = (SELECT TO_VARCHAR(CURRENT_DATE(), 'yyyymmdd'));

SET Path =  (SELECT '.*products_'|| $DATEVAR || '.csv');

SELECT $Path;

COPY INTO PRODUCTS 
FROM (select $1, $2, $3, $4, metadata$filename from @PRODUCT_STAGE (PATTERN=>$Path));

-- Validating the data
SELECT * FROM PRODUCTS;