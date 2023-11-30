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

--Query to see contents of the Table Stage
SELECT * FROM @%CATEGORY;

--Query to see the files in the Table Stage
LIST @%CATEGORY;

/*----------------Create Internal Named Stage----------------*/

CREATE OR REPLACE STAGE MY_INTERNAL_STAGE
    FILE_FORMAT = (type = csv field_delimiter = ',' skip_header = 1);

--Show all stages
SHOW STAGES;

--List files in internal stage
LIST @MY_INTERNAL_STAGE;

--Place the file from your terminal using "put file://C:\ANGE_SnowflakeWorkshop_DrM\Internal_Stage_Load\category.csv @MANAGE_DB.INTERNAL_STAGES.MY_INTERNAL_STAGE;"

--Load data into table from Internal Named Stage
COPY INTO CATEGORY
    FROM @MY_INTERNAL_STAGE/category.csv.gz
    FILE_FORMAT = (type = csv field_delimiter = ',' skip_header = 1);

-- Validate data in table
SELECT * FROM CATEGORY;