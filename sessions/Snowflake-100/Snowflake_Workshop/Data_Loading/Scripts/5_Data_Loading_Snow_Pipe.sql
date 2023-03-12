
--For this example we use the same storage integration we created. We are going to use the Sales files for this example

--Lets create a file format for JSON File
CREATE FILE FORMAT JSON_FILE
	TYPE = JSON
    STRIP_OUTER_ARRAY = TRUE;

--Creating the Sales Stage
CREATE OR REPLACE STAGE sales_stage
  STORAGE_INTEGRATION=s3_int
  URL = 's3://bala-snowflake-workshop-20230307/Sales/'
  FILE_FORMAT = JSON_FILE;

--Creating the Sales Table for this Example
CREATE OR REPLACE TABLE SALES (
	SALES_ITEM VARIANT
    , FILENAME VARCHAR(256)
);

--Creating the Sales snowPipe by configuring the Copy statement
CREATE OR REPLACE PIPE SALES_PIPE 
	AUTO_INGEST=TRUE AS 
    	COPY INTO SALES FROM (SELECT $1, metadata$filename from @sales_stage);

--Get the details of Snowpipe. Get the value of the SQS queue mentioned in the notification_channel column and set up event notification in AWS 
-- by following below steps

--Configure an event notification for your S3 bucket using the instructions provided in the Amazon S3 documentation. Complete the fields as follows:

--Name: Name of the event notification (e.g. Auto-ingest Snowflake).
--Events: Select the ObjectCreate (All) option.
--Send to: Select SQS Queue from the dropdown list.
--SQS: Select Add SQS queue ARN from the dropdown list.
--SQS queue ARN: Paste the SQS queue name from the SHOW PIPES output.

SHOW PIPES;


--Get the details of the snowpipe status with this comment
SELECT SYSTEM$PIPE_STATUS('SALES_PIPE');

--Validate the data in the file
SELECT * FROM SALES;