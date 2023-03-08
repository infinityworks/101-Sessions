--Steps to complete in Local System
--Download the category.csv file to your local system
--Login to snowflake using "snowsql -a <snowflake-account> -u <username>"
--place the file into table stage using "put file:///<path to file>/category.csv @%category;"


--Steps to complete in snowflake UI
--Login to Loader user
--Execute the scripts in the below order.
--Statements to set the context for this worksheet
USE ROLE LOADER;

USE DATABASE RAW;
USE SCHEMA RETAIL;

--Create file formats

CREATE FILE FORMAT CSV_WITH_COMMAS 
	TYPE = CSV
    SKIP_HEADER = 1
    COMPRESSION = gzip;



--Query to see contents of the table stage    
SELECT * FROM @%CATEGORY;

--Query to see the files in the table stage
LIST @%CATEGORY;

--Copy statement to copy the files into the table
COPY INTO CATEGORY
FILE_FORMAT = (FORMAT_NAME = 'CSV_WITH_COMMAS');

--Verify whether the data has been transferred
SELECT * FROM CATEGORY
