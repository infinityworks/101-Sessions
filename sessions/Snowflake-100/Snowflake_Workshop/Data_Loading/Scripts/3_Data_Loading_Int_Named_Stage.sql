--Creating a Internal Stage
CREATE OR REPLACE STAGE MY_INTERNAL_STAGE
FILE_FORMAT = CSV_WITH_COMMAS;

--Displaying the list of stages present
SHOW STAGES;

--List the contents of internal stage
LIST @MY_INTERNAL_STAGE;

--Creating the tables

CREATE TABLE REGIONS (
  REGION_ID NUMBER(10,0)
  , REGION_NAME VARCHAR(64)
);

--Place the file from your terminal using "put file://Documents/GitHub/101-Sessions/sessions/Snowflake-100/Snowflake_Workshop/Data_Loading/files/regions.csv @MY_INTERNAL_STAGE;"
--Copy into the tables
COPY INTO REGIONS FROM @MY_INTERNAL_STAGE/regions.csv.gz
FILE_FORMAT = (FORMAT_NAME = CSV_WITH_COMMAS);
