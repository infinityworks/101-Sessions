--Switch roles to ACCOUNTADMIN

USE ROLE ACCOUNTADMIN;

--Statement to create database

CREATE DATABASE STAGE_DB;

--Setting up Time Travel number of days in DB level. Normally it will apply based on Account level
ALTER DATABASE STAGE_DB SET DATA_RETENTION_TIME_IN_DAYS=30;

--Validating the Timetravel days set in Account Level
SHOW PARAMETERS like '%DATA_RETENTION_TIME_IN_DAYS%' in account;

--Statement to create schema

CREATE SCHEMA STAGE_SCHEMA;

-- Permanent Table Creation

CREATE TABLE CATEGORY
(
	CATEGORY_ID NUMBER(10,0) NOT NULL
    , CATEGORY_NAME VARCHAR(64)
);


-- Transient Table Creation

CREATE TRANSIENT TABLE SUBCATEGORY
(
	SUBCATEGORY_ID NUMBER(10,0) NOT NULL
    , SUBCATEGORY_NAME VARCHAR(64) NOT NULL
    , CATEGORY_ID NUMBER(10,0) NOT NULL
);

--Temporary Table Creation

CREATE TEMPORARY TABLE PRODUCTS (
	PRODUCT_ID NUMBER(10,0) NOT NULL,
	PRODUCT_NAME VARCHAR(256) NOT NULL,
	UNIT_PRICE NUMBER(10,2) NOT NULL,
	SUBCATEGORY_ID NUMBER(10,0) NOT NULL,
    FILENAME VARCHAR(256) NOT NULL
);

--Validating the number of rows and access to differentiate Temporary Tables. Create new worksheet to validate

SELECT COUNT(*) FROM CATEGORY;
SELECT COUNT(*) FROM SUBCATEGORY;
SELECT COUNT(*) FROM PRODUCTS;

--Validate the number of days the Time travel is enabled for each type of Tables
SHOW TABLES LIKE  'CATEGORY';

SHOW TABLES LIKE 'SUBCATEGORY';

SHOW TABLES LIKE 'PRODUCTS';