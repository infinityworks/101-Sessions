/*----------------Loading using Internal Stage Hands-on----------------
1) Meaning of Table Stage
2) Creating Internal Named Stage
3) Loading using Internal Named Stage
----------------------------------------------*/

-- Create Database and Schemas
CREATE DATABASE MANAGE_DB;
CREATE OR REPLACE SCHEMA MANAGE_DB.INTERNAL_STAGES;

-- Set context
USE WAREHOUSE COMPUTE_WH;
USE DATABASE MANAGE_DB;
USE SCHEMA INTERNAL_STAGES;

-- Create table
CREATE TABLE CATEGORY
(
    CATEGORY_ID NUMBER(10,0) NOT NULL,
    CATEGORY_NAME VARCHAR(64)
);

/*----------------Create Internal Named Stage----------------*/

CREATE OR REPLACE STAGE MY_INTERNAL_STAGE
    FILE_FORMAT = (type = csv field_delimiter = ',' skip_header = 1);

--Show all stages
SHOW STAGES;

--List files in internal stage
LIST @MY_INTERNAL_STAGE;

--In your terminal, connect to this Snowflake account using snowql.
--The below SQL command will help you get your account identifier. 

select concat(CURRENT_ORGANIZATION_NAME(),'-',CURRENT_ACCOUNT_NAME());

-- In your terminal, cd to the directory containing the data to load

--Then we can run "snowsql -a <account_identifer> -u <username>"

--Place the file from your terminal using "put file://category.csv @MANAGE_DB.INTERNAL_STAGES.MY_INTERNAL_STAGE;"

--Load data into table from Internal Named Stage
COPY INTO CATEGORY
FROM @MY_INTERNAL_STAGE/category.csv.gz;

-- Validate data in table
SELECT * FROM CATEGORY;