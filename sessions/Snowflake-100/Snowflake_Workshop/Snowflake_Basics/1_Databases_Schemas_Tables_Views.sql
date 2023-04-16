/*----------------3-Databases Schemas Tables and Views Hands-on----------------
1) Introduce Databases & schemas
2) Understand table and view types
----------------------------------------------*/

-- Set context
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE SNOWFLAKE_SAMPLE_DATA;
USE SCHEMA TPCH_SF1;

--"SNOWFLAKE_SAMPLE_DATA"."WEATHER"."DAILY_14_TOTAL"

-- Describe table schema
DESC TABLE CUSTOMER;

-- Provide details on all tables in current context
SHOW TABLES;

-- Filter output of SHOW TABLES using LIKE string matching
SHOW TABLES LIKE 'CUSTOMER';

SELECT "name", "database_name", "schema_name", "kind", "is_external", "retention_time" FROM TABLE(result_scan(last_query_id()));

-- Create demo database & schema
CREATE DATABASE DEMO_DB;
CREATE SCHEMA DEMO_SCHEMA;

USE DATABASE DEMO_DB;
USE SCHEMA DEMO_SCHEMA;

-- Create three table types
CREATE TABLE PERMANENT_TABLE
(
  NAME STRING,
  AGE INT
  );

CREATE TEMPORARY TABLE TEMPORARY_TABLE
(
  NAME STRING,
  AGE INT
  );

CREATE TRANSIENT TABLE TRANSIENT_TABLE
(
  NAME STRING,
  AGE INT
  );

SHOW TABLES;

SELECT "name", "database_name", "schema_name", "kind", "is_external" FROM TABLE(result_scan(last_query_id()));

-- Successful
ALTER TABLE PERMANENT_TABLE SET DATA_RETENTION_TIME_IN_DAYS = 90;

-- Invalid value [90]
ALTER TABLE TRANSIENT_TABLE SET DATA_RETENTION_TIME_IN_DAYS = 2;

-- Create two views - one of each type

CREATE VIEW STANDARD_VIEW AS
SELECT * FROM PERMANENT_TABLE;

CREATE MATERIALIZED VIEW MATERIALIZED_VIEW AS
SELECT * FROM PERMANENT_TABLE;

SHOW VIEWS;

SELECT "name", "database_name", "schema_name", "is_materialized" FROM TABLE(result_scan(last_query_id()));
