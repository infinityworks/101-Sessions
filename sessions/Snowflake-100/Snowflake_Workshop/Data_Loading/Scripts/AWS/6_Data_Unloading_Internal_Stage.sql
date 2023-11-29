/*----------------Unloading using Internal Stage Hands-on----------------
1) Unloading using Internal Stage
----------------------------------------------*/

-- Set Context
USE WAREHOUSE COMPUTE_WH;
USE DATABASE MANAGE_DB;
USE SCHEMA INTERNAL_STAGES;

--Create a Named Stage
CREATE OR REPLACE STAGE PRODUCT_UNLOAD_STAGE
    FILE_FORMAT = (type = csv field_delimiter = ',' skip_header = 1);

--List Stage
LIST @PRODUCT_UNLOAD_STAGE;

--Copy the contents into the Internal stage
COPY INTO @PRODUCT_UNLOAD_STAGE/unload/ FROM DEMO_DB.DEMO_SCHEMA.PRODUCTS;

--Verify if the file has been loaded into the stage
LIST @PRODUCT_UNLOAD_STAGE;

--Login to snowflake using "snowsql -a <snowflake-account> -u <username>"
--Use below commands:
---- Mac/Linux: GET @mystage/unload/data_0_0_0.csv.gz file:///data/unload;
---- Windows: GET @mystage/unload/data_0_0_0.csv.gz file://C:\data\unload;

--On command windows
-- GET @MANAGE_DB.INTERNAL_STAGES.product_unload_stage/unload/data_0_0_0.csv.gz file://C:\ANGE_SnowflakeWorkshop_DrM\Internal_Stage_Unload;