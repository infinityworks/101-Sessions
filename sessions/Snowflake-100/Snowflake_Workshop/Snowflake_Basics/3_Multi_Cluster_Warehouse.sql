/*----------------3-Multi Cluster Warehouse Hands-on----------------
1) Multi-cluster warehouse behaviour
2) Meaning of the MIN[/MAX]_CLUSTER_COUNT option
3) Meaning of the SCALING_POLICY option
----------------------------------------------*/

-- Set context
USE ROLE SYSADMIN;

CREATE OR REPLACE WAREHOUSE MULTI_CLUSTER_WAREHOUSE_STANDARD_XS
WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 600
AUTO_RESUME = TRUE
MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 2
SCALING_POLICY = 'STANDARD';

SHOW WAREHOUSES LIKE 'MULTI%';

-- Clear-down resources
DROP WAREHOUSE MULTI_CLUSTER_WAREHOUSE_STANDARD_XS;