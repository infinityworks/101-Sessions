--Creating the Internal named stage
USE ROLE DEPLOYER;
USE WAREHOUSE LOADER_WH;

CREATE OR REPLACE STAGE MY_INTERNAL_STAGE
FILE_FORMAT = CSV_WITH_COMMAS;

--Granting the access to Loader role for operating on the Stage
GRANT READ, WRITE ON STAGE RAW.RETAIL.MY_INTERNAL_STAGE TO LOADER;

USE ROLE LOADER;

SHOW STAGES;

--List the contents of internal stage
LIST @MY_INTERNAL_STAGE;

--Place the file from your terminal using "put file://Documents/GitHub/101-Sessions/sessions/Snowflake-100/Snowflake_Workshop/Data_Loading/files/regions.csv @MY_INTERNAL_STAGE;"
--Copy into the tables
COPY INTO REGIONS FROM @MY_INTERNAL_STAGE/regions.csv.gz;


