--Lets create a table from the snowflake share

CREATE TABLE CUSTOMER
AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.CUSTOMER;


--Creating regular view
CREATE VIEW CUSTOMER_VIEW
AS
SELECT * FROM CUSTOMER;

--creating Materialized View
CREATE MATERIALIZED VIEW CUSTOMER_VIEW_MATERIALIZED
AS
SELECT * 
FROM CUSTOMER;

--Select statement to explain the time difference it has for materialized view
SELECT * FROM CUSTOMER_VIEW;

SELECT * FROM CUSTOMER_VIEW_MATERIALIZED;


--Statements to explain the effect of Views when there is a structure change in Tables
ALTER TABLE CUSTOMER DROP COLUMN C_MKTSEGMENT;

SELECT * FROM CUSTOMER_VIEW;

SELECT * FROM CUSTOMER_VIEW_MATERIALIZED;