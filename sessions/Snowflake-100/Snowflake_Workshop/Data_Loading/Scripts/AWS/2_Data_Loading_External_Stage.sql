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

-- Got to AWS and create our S3 bucket, and a role that has access to the bucket, using this guide
-- https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration

-- Create Storage Integration
CREATE OR REPLACE STORAGE INTEGRATION s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<arn of the role in AWS>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://<bucket_name>/');

DESC INTEGRATION S3_INT;
-- Now we need to update the trust policy of the role we created.

-- Create External Stage
CREATE OR REPLACE STAGE product_stage
  STORAGE_INTEGRATION = s3_int
  URL = 's3://<bucket name>/'
  FILE_FORMAT = FILE_FORMATS.CSV_PIPE_DELIMITED;

--List files in stage
-- (update trust policy if needed in AWS (https://community.snowflake.com/s/article/S3-Storage-Integration-Error-assuming-AWS-ROLE))
LIST @PRODUCT_STAGE;

--Loading into table using Copy command and using Pattern
COPY INTO DEMO_DB.DEMO_SCHEMA.PRODUCTS
FROM (SELECT $1, $2, $3, $4, metadata$filename from @PRODUCT_STAGE);

-- Validating the data
SELECT * FROM DEMO_DB.DEMO_SCHEMA.PRODUCTS;