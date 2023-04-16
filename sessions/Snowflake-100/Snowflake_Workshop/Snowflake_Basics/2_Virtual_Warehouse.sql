/*----------------3-Virtual Warehouse Hands-on----------------
1) Virtual warehouse creation
2) Virtual warehouse sizes
3) Virtual warehouse state properties
4) Virtual warehouse behaviour
----------------------------------------------*/

-- Set context
USE ROLE SYSADMIN;

-- Create data loading analysis warehouse
CREATE WAREHOUSE DATA_ANALYSIS_WAREHOUSE
WAREHOUSE_SIZE = 'SMALL'
AUTO_SUSPEND = 600
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED=TRUE;

-- Set context
USE WAREHOUSE  DATA_ANALYSIS_WAREHOUSE;
USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000;

-- Manually resume virtual warehouse
ALTER WAREHOUSE DATA_ANALYSIS_WAREHOUSE RESUME;

-- Show state of virtual warehouse
SHOW WAREHOUSES LIKE 'DATA_ANALYSIS_WAREHOUSE';

-- Manually suspend virtual warehouse
ALTER WAREHOUSE DATA_ANALYSIS_WAREHOUSE SUSPEND;

SHOW WAREHOUSES LIKE 'DATA_ANALYSIS_WAREHOUSE';

SELECT
C_CUSTKEY,
C_NAME,
C_ADDRESS,
C_NATIONKEY,
C_PHONE FROM CUSTOMER LIMIT 100;

SHOW WAREHOUSES LIKE 'DATA_ANALYSIS_WAREHOUSE';

-- Set configurations on-the-fly
ALTER WAREHOUSE DATA_ANALYSIS_WAREHOUSE SET WAREHOUSE_SIZE=LARGE;

ALTER WAREHOUSE DATA_ANALYSIS_WAREHOUSE SET AUTO_SUSPEND=300;

ALTER WAREHOUSE DATA_ANALYSIS_WAREHOUSE SET AUTO_RESUME=FALSE;

SHOW WAREHOUSES LIKE 'DATA_ANALYSIS_WAREHOUSE';
SELECT "name", "state", "size", "auto_suspend", "auto_resume" FROM TABLE(result_scan(last_query_id()));

-- Clear-down resources
DROP WAREHOUSE DATA_ANALYSIS_WAREHOUSE;