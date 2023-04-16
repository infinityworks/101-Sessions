/*----------------Unloading using External Stage Hands-on----------------
1) Unloading using External Stage
----------------------------------------------*/

-- Set Context
USE WAREHOUSE COMPUTE_WH;
USE DATABASE MANAGE_DB;
USE SCHEMA EXTERNAL_STAGES;

--Create a stage to unload a file. you dont need separate stage if you want to paste in sub folders you can use existing one
CREATE OR REPLACE STAGE AZURE_UNLOAD_STAGE
    URL = 'azure://snowflakeworkshop.blob.core.windows.net/snowflakeworkshopfiles/unload/products/'
    CREDENTIALS =(azure_sas_token='REPLACE_WITH_SAS_TOKEN_PROVIDED_BY_INSTRUCTOR')
    FILE_FORMAT = FILE_FORMATS.CSV_PIPE_DELIMITED;

--List Azure Stage
LIST @AZURE_UNLOAD_STAGE;

--Copy statement to copy the content to Azure location
COPY INTO @AZURE_UNLOAD_STAGE/Unload.csv.gz
FROM (SELECT * FROM DEMO_DB.DEMO_SCHEMA.PRODUCTS)
single = true --Option if you want to create it as single files. By default it will be split into small files
header = true;-- If you want to create the files with Header