-- ROLE BASED ACCESS CONTROL

-- STEP 1 create roles
use role useradmin;

create role if not exists deployer;
create role if not exists transformer;
create role if not exists reporter;

---------------------------------------------------------------------------------------------------
-- STEP 2 set up roles hierarchy
use role securityadmin;

-- grant roles to roles
grant role deployer to role sysadmin;
grant role transformer to role sysadmin;
grant role reporter to role sysadmin;

---------------------------------------------------------------------------------------------------
-- STEP 3 create objects
use role accountadmin;

-- grant create databse and warehouse to deployer role
grant create database on account to role deployer;
grant create warehouse on account to role deployer;

-- create databases
use role deployer;
create database if not exists jaffleshop;

-- create schemas
create schema if not exists jaffleshop.retail;
show schemas;

--create tables
create table if not exists jaffleshop.retail.products (col int);
create table if not exists jaffleshop.retail.customers (col int);
show tables;

-- create warehouse
create warehouse if not exists transformer_wh
warehouse_size = 'xsmall';


-- grant usage on warehouse to reporer
-------------------------------------------------------------------------------------------------
grant usage on warehouse transformer_wh to role transformer;

---------------------------------------------------------------------------------------------------
-- STEP 4 grant privileges on securable objects to roles
-- grant read and write access to the transformer role
-------------------------------------------------------------------------------------------------
grant usage on database jaffleshop to role transformer;
grant usage on schema jaffleshop.retail to role transformer;
grant all privileges on schema jaffleshop.retail to role transformer;
grant all privileges on all tables in database jaffleshop to role transformer;
grant all privileges on all tables in database jaffleshop to role transformer;

-- grant read-only access on to the reporter role
-------------------------------------------------------------------------------------------------
grant usage on database jaffleshop to role reporter;
grant usage on schema jaffleshop.retail to role reporter;
grant select on all tables in database jaffleshop to role reporter;

show grants on database jaffleshop;
show grants on schema jaffleshop.retail;
show grants on table jaffleshop.retail.customers;

---------------------------------------------------------------------------------------------------
--STEP 5 create users and assingn roles
use role useradmin;

create user if not exists transformer_1
password = 'password123'
default_role = transformer
must_change_password = false;

create user if not exists reporter_1
password = 'password123'
default_role = reporter
must_change_password = false;

use role securityadmin;
grant role transformer to user transformer_1;
grant role reporter to user reporter_1;

--STEP 6 test out the users
---------------------------------------------------------------------------------------------------
-- Login as the transformer_1 user
use role transformer;
use warehouse transformer_wh;
use schema jaffleshop.retail;

-- Insert and delete some dummy data
insert into customers
select seq4()
from table(generator(rowcount => 100));

delete from jaffleshop.retail.customers
where col < 10;

-- Login as the reporter_1 user

use role reporter;
select * from jaffleshop.retail.customers;
-- there's no warehouse for the reporter role to use!


--Exercise
-- Log back in as your admin user
-- Create new warehouse called 'reporter_wh' that is owned by the deployer role.
-- Allow the reporter role to use this warehouse. 

-- start here: