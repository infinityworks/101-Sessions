use role accountadmin;
-- STEP 1 create roles
use role useradmin;
create role QA;

---------------------------------------------------------------------------------------------------
-- STEP 2 set up roles hierarchy
use role securityadmin;
grant role QA to role data_owner;
grant role analytics_reader to role QA;
grant role raw_reader to role QA;


---------------------------------------------------------------------------------------------------
-- STEP 3 create objects
use role deployer;

create warehouse QA_wh
warehouse_size = 'xsmall'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true;

---------------------------------------------------------------------------------------------------
-- STEP 4 grant privileges on securable objects to roles
use role deployer;
grant usage on warehouse QA_wh to role QA;
---------------------------------------------------------------------------------------------------
--STEP 5 create users and assingn roles
use role useradmin;
create user QA_1
password = 'rome123'
default_role = tester
must_change_password = false;
use role securityadmin;
grant role QA to user QA_1;
