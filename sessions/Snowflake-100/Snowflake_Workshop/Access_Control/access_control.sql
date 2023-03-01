-- STEP 1 create roles
use role securityadmin;

-- main roles
create role data_owner;
create role deployer;
-- functional roles
create role loader;
create role data_engineer;
create role tester;
create role reporter;
-- access roles
create role analytics_reader;
create role analytics_writer;
create role raw_reader;
create role raw_writer;
---------------------------------------------------------------------------------------------------
-- STEP 2 set up roles hierarchy
use role securityadmin;

-- grant roles to roles
grant role data_owner to role sysadmin;
grant role deployer to role data_owner;
grant role loader to role data_owner;
grant role data_engineer to role data_owner;
grant role tester to role data_owner;
grant role reporter to role data_owner;

grant role analytics_reader to role analytics_writer;
grant role analytics_reader to role reporter;
grant role analytics_reader to role tester;
grant role analytics_writer to role data_engineer;

grant role raw_reader to role raw_writer;
grant role raw_reader to role data_engineer;
grant role raw_reader to role tester;
grant role raw_writer to role loader;
---------------------------------------------------------------------------------------------------
-- STEP 3 create objects
use role accountadmin;

-- grant create databse and warehouse to master role
grant create database on account to role deployer;
grant create warehouse on account to role deployer;
-- create databases
use role deployer;

create database raw;
create database analytics;
show databases;
-- create schemas
create schema raw.retail;
create schema analytics.marts;
show schemas;
--create tables
create table raw.retail.category (col int);
create table raw.retail.products (col int);
create table raw.retail.regions (col int);
create table raw.retail.stores (col int);
create table raw.retail.subcategory (col int);
create table analytics.marts.fact_sales (col int);
create table analytics.marts.dim_product (col int);
show tables;
-- create warehouses
create warehouse loader_wh
warehouse_size = 'medium'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true;
create warehouse reporter_wh 
warehouse_size = 'xsmall'
warehouse_type = 'standard'
min_cluster_count = 2
max_cluster_count = 4
auto_suspend = 600
auto_resume = true;
create warehouse transformer_xs_wh 
warehouse_size = 'xsmall'
warehouse_type = 'standard'
min_cluster_count = 1
max_cluster_count = 5
auto_suspend = 60
auto_resume = true;
create warehouse transformer_xl_wh 
warehouse_size = 'xlarge'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true;
create warehouse tester_wh 
warehouse_size = 'xsmall'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true;
show warehouses;
---------------------------------------------------------------------------------------------------
-- STEP 4 grant privileges on securable objects to roles
use role deployer;

-- grant read-write access on database raw to role raw_writer
-------------------------------------------------------------------------------------------------
grant usage on database raw to role raw_writer;
grant usage on all schemas in database raw to role raw_writer;
grant all privileges on all schemas in database raw to role raw_writer;
grant all privileges on all tables in database raw to role raw_writer;
-- grant read-only access on database raw to role raw_reader
-------------------------------------------------------------------------------------------------
grant usage on database raw to role raw_reader;
grant usage on all schemas in database raw to role raw_reader;
grant select on all tables in database raw to role raw_reader;
-- grant read-write access on database analytics to role analytics_writer
-------------------------------------------------------------------------------------------------
grant usage on database analytics to role analytics_writer;
grant usage on all schemas in database analytics to role analytics_writer;
grant all privileges on all schemas in database analytics to role analytics_writer;
grant all privileges on all tables in database analytics to role analytics_writer;

-- grant read-only access on database analytics to role analytics_reader
-------------------------------------------------------------------------------------------------
grant usage on database analytics to role analytics_reader;
grant usage on all schemas in database analytics to role analytics_reader;
grant select on all tables in database analytics to role analytics_reader;

show grants on database raw;
show grants on database analytics;
-- grant usage on warehouse my_wh
-------------------------------------------------------------------------------------------------
grant usage on warehouse loader_wh to role loader;
grant usage on warehouse transformer_xs_wh to role data_engineer;
grant usage on warehouse transformer_xl_wh to role data_engineer;
grant usage on warehouse reporter_wh to role reporter;
grant usage on warehouse tester_wh to role tester;
---------------------------------------------------------------------------------------------------
--STEP 5 create users and assing roles 
use role useradmin;

create user do_1
password = 'rome123' 
default_role = data_engineer 
must_change_password = false;
create user de_1 
password = 'rome123' 
default_role = data_engineer 
must_change_password = false;
create user tester_1 
password = 'rome123' 
default_role = tester 
must_change_password = false;
create user reporter_1 
password = 'rome123' 
default_role = data_engineer 
must_change_password = false;
create user loader_1 
password = 'rome123' 
default_role = loader 
must_change_password = false;

use role securityadmin;
grant role data_owner to user do_1;
grant role data_engineer to user de_1;
grant role tester to user tester_1;
grant role reporter to user reporter_1;
grant role loader to user loader_1;





