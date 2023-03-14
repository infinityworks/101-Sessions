-- ROLE BASES ACCESS CONTROL

-- STEP 1 create roles
use role useradmin;

-- main roles
create role if not exists data_owner;
create role if not exists deployer;
-- functional roles
create role if not exists loader;
create role if not exists transformer;
create role if not exists reporter;

-- access roles
create role if not exists analytics_reader;
create role if not exists analytics_writer;
create role if not exists raw_reader;
create role if not exists raw_writer;
---------------------------------------------------------------------------------------------------
-- STEP 2 set up roles hierarchy
use role securityadmin;

-- grant roles to roles
grant role data_owner to role sysadmin;
grant role deployer to role data_owner;
grant role loader to role data_owner;
grant role transformer to role data_owner;
grant role reporter to role data_owner;

grant role analytics_reader to role analytics_writer;
grant role analytics_reader to role reporter;
grant role analytics_writer to role transformer;

grant role raw_reader to role raw_writer;
grant role raw_reader to role transformer;
grant role raw_writer to role loader;
---------------------------------------------------------------------------------------------------
-- STEP 3 create objects
use role accountadmin;

-- grant create databse and warehouse to deployer role
grant create database on account to role deployer;
grant create warehouse on account to role deployer;

-- create databases
use role deployer;

create database if not exists raw;
create database if not exists analytics;
show databases;
-- create schemas
create schema if not exists raw.retail;
create schema if not exists analytics.marts;
show schemas;
--create tables
create table if not exists raw.retail.category (col int);
create table if not exists raw.retail.products (col int);
create table if not exists raw.retail.regions (col int);
create table if not exists raw.retail.stores (col int);
create table if not exists raw.retail.subcategory (col int);
create table if not exists analytics.marts.fact_sales (col int);
create table if not exists analytics.marts.dim_product (col int);
show tables;
-- create warehouses
create warehouse if not exists loader_wh
warehouse_size = 'medium'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true;
create warehouse if not exists reporter_wh
warehouse_size = 'xsmall'
warehouse_type = 'standard'
min_cluster_count = 2
max_cluster_count = 4
auto_suspend = 600
auto_resume = true;
create warehouse if not exists transformer_xs_wh
warehouse_size = 'xsmall'
warehouse_type = 'standard'
min_cluster_count = 1
max_cluster_count = 5
auto_suspend = 60
auto_resume = true;
create warehouse if not exists transformer_xl_wh
warehouse_size = 'xlarge'
warehouse_type = 'standard'
auto_suspend = 60
auto_resume = true;

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
grant usage on warehouse transformer_xs_wh to role transformer;
grant usage on warehouse transformer_xl_wh to role transformer;
grant usage on warehouse reporter_wh to role reporter;
---------------------------------------------------------------------------------------------------
--STEP 5 create users and assingn roles
use role useradmin;

create user if not exists do_1
password = 'password123'
default_role = transformer
must_change_password = false;

create user if not exists de_1
password = 'password123'
default_role = transformer
must_change_password = false;

create user if not exists reporter_1
password = 'password123'
default_role = transformer
must_change_password = false;

create user if not exists loader_1
password = 'password123'
default_role = loader
must_change_password = false;

use role securityadmin;
grant role data_owner to user do_1;
grant role transformer to user de_1;
grant role reporter to user reporter_1;
grant role loader to user loader_1;

--Exercise
-- Add to the RBAC created above a role "QA" able to read both the raw and analytics database.
-- Create also a QA warehouse granted to this role and a QA user

-- start here:
