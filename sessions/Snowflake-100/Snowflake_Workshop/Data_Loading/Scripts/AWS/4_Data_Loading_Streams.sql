/*----------------Streams Hands-on----------------
1) Create Insert Stream
2) Create Update Stream
3) Create Delete Stream
----------------------------------------------*/
-- Set context
USE WAREHOUSE COMPUTE_WH;

--******** Stream : INSERT ********
CREATE OR REPLACE DATABASE STREAMS_DB;
CREATE OR REPLACE SCHEMA STREAMS_SCHEMA;

-- Create table
CREATE OR REPLACE TABLE SALES_RAW_STAGING(
  id varchar,
  product varchar,
  price varchar,
  amount varchar,
  store_id varchar);

-- INSERT VALUES
INSERT INTO SALES_RAW_STAGING
VALUES
(1,'Banana',1.99,1,1),
(2,'Lemon',0.99,1,1),
(3,'Apple',1.79,1,2),
(4,'Orange Juice',1.89,1,2),
(5,'Cereals',5.98,2,1);


CREATE OR REPLACE TABLE STORE_TABLE(
  store_id number,
  location varchar,
  employees number);


INSERT INTO STORE_TABLE VALUES
(1,'Chicago',33),
(2,'London',12);

CREATE OR REPLACE TABLE SALES_FINAL_TABLE(
  id int,
  product varchar,
  price number,
  amount int,
  store_id int,
  location varchar,
  employees int);

 -- Insert into final table
INSERT INTO SALES_FINAL_TABLE
    SELECT
    SA.id,
    SA.product,
    SA.price,
    SA.amount,
    ST.STORE_ID,
    ST.LOCATION,
    ST.EMPLOYEES
    FROM SALES_RAW_STAGING SA
    JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID ;

SELECT * FROM SALES_FINAL_TABLE;

-- Create a stream object
CREATE OR REPLACE STREAM SALES_STREAM ON TABLE SALES_RAW_STAGING;

SHOW STREAMS;

--******** Stream : INSERT ********
SELECT * FROM SALES_STREAM;

SELECT * FROM SALES_RAW_STAGING;


-- insert values
INSERT INTO SALES_RAW_STAGING
    VALUES
        (6,'Mango',1.99,1,2),
        (7,'Garlic',0.99,1,1);

-- Get changes on data using stream
SELECT * FROM SALES_STREAM;

SELECT * FROM SALES_RAW_STAGING;

SELECT * FROM SALES_FINAL_TABLE;


-- Consume stream object
INSERT INTO SALES_FINAL_TABLE
    SELECT
    SA.id,
    SA.product,
    SA.price,
    SA.amount,
    ST.STORE_ID,
    ST.LOCATION,
    ST.EMPLOYEES
    FROM SALES_STREAM SA
    JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID ;

-- Now the final table is up to date
SELECT * FROM SALES_FINAL_TABLE;

-- The stream has been consumed so is now empty
SELECT * FROM SALES_STREAM;


--******** Stream : UPDATE ********

SELECT * FROM SALES_RAW_STAGING;

SELECT * FROM SALES_STREAM;

UPDATE SALES_RAW_STAGING
SET PRODUCT ='Potato' WHERE PRODUCT = 'Banana';

SELECT * FROM SALES_RAW_STAGING;

SELECT * FROM SALES_STREAM;

MERGE INTO SALES_FINAL_TABLE f      -- Target table to merge changes from source table
USING SALES_STREAM s                -- Stream that has captured the changes
   ON  f.id = s.id
WHEN MATCHED
    AND s.METADATA$ACTION ='INSERT'
    AND s.METADATA$ISUPDATE ='TRUE'        -- Indicates the record has been updated
    THEN UPDATE
    SET f.product = s.product,
        f.price = s.price,
        f.amount= s.amount,
        f.store_id=s.store_id;


SELECT * FROM SALES_FINAL_TABLE;

SELECT * FROM SALES_STREAM;


-- ******* Stream : DELETE  ********

SELECT * FROM SALES_FINAL_TABLE;

SELECT * FROM SALES_RAW_STAGING;

SELECT * FROM SALES_STREAM;

DELETE FROM SALES_RAW_STAGING
WHERE PRODUCT = 'Lemon';

MERGE INTO SALES_FINAL_TABLE F      -- Target table to merge changes from source table
USING SALES_STREAM s                -- Stream that has captured the changes
   ON  f.id = s.id
WHEN MATCHED
    AND s.METADATA$ACTION ='DELETE'
    AND s.METADATA$ISUPDATE = 'FALSE'
    THEN DELETE ;

SELECT * FROM SALES_STREAM;

SELECT * FROM SALES_FINAL_TABLE;

SELECT * FROM SALES_RAW_STAGING;


-- ******* Dynamic Tables  ********
-- That's a lot of code to keep the final table up to date

USE SCHEMA STREAMS_DB.STREAMS_SCHEMA;

CREATE OR REPLACE DYNAMIC TABLE SALES_FINAL_TABLE_DYNAMIC
TARGET_LAG = '1 minute'
WAREHOUSE = compute_wh
AS
SELECT
    SA.id,
    SA.product,
    SA.price,
    SA.amount,
    ST.STORE_ID,
    ST.LOCATION,
    ST.EMPLOYEES
    FROM SALES_RAW_STAGING SA
    JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID ;


SELECT * FROM SALES_FINAL_TABLE_DYNAMIC;

-- Update the underlying data

INSERT INTO SALES_RAW_STAGING
    VALUES
        (8,'Grapes',1.50,1,2),
        (9,'Nuts',0.95,1,1);

UPDATE STORE_TABLE SET LOCATION = 'LDN' where LOCATION = 'London';

SELECT * FROM SALES_FINAL_TABLE_DYNAMIC;

-- Can use the below to manually force a refresh if needed.
ALTER DYNAMIC TABLE SALES_FINAL_TABLE_DYNAMIC REFRESH