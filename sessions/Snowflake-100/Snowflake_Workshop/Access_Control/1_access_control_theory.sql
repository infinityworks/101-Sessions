-- ROLES AND USERS

-- Creation of a user
-- USERADMIN is the recommended role to be used to create users
use role useradmin;
create user user1;

-- Creation of a role:
-- Useradmin has the privileges to create roles
use role useradmin;
create role role1;
grant role role1 to role sysadmin;

-- as the owner of the role, it can grant the role to users. securityadmin can also grant the role
grant role role1 to user user1;
show roles like 'role1';
show grants on role role1;

-- Trying creating a role with sysadmin will trigger an error i.e. Insufficient privileges to operate on account
use role sysadmin;
create role role2;


-- Let's check what we have:
-- role1 has been granted to one user - user1, and one role - sysadmin
show grants of role role1;

-- user1 has the grant to role1
show grants to user user1;

-- SECURABLE OBJECTS

-- Create Objects
-- SYSADMIN is the default role to use to create objects
use role sysadmin;
create database db1;

-- the below won't work as SECURITYADMIN does not have privileges to create databses
use role securityadmin;
create database db2;

-- let's check what we have. The owner of the object is SYSADMIN. Note, there is no show grants to database as "grants to" is for roles and users
show databases like 'db1';
show grants on database db1;

-- Let's change the ownership of the database
grant ownership on database db1 to role role1;
-- now we can see the owner has changed
show databases like 'db1';

-- PRIVILEGES

-- create some objects
use role sysadmin;
create warehouse wh1 warehouse_size = 'xsmall' warehouse_type = 'standard' auto_suspend = 60 auto_resume = true;
create schema db1.schema1;
create table db1.schema1.table1 (col int);
insert into db1.schema1.table1 (col) VALUES (1),(2),(3),(4),(5);
select * from db1.schema1.table1;
show schemas like 'schema1';
show tables like 'table1';
show warehouses like 'wh1';

-- Grant usage privileges on objects to roles
use role role1; -- switching role I lose access to all the previous objctes
show schemas like 'schema1';
show tables like 'table1';
show warehouses like 'wh1';

-- I can use either securityadmin, role that can manage all grants, or the role used to create these objects which has the OWNERSHIP privilege. In this case, sysadmin.
use role securityadmin;
grant usage on database db1 to role role1;
grant usage on warehouse wh1 to role role1;
use role sysadmin;
grant usage on schema db1.schema1 to role role1;
grant select on table db1.schema1.table1 to role role1;

use role role1;
use warehouse wh1;
select * from db1.schema1.table1;


-- Grant alter privileges on objects to roles
insert into db1.schema1.table1 (col) VALUES (6),(7),(8),(9),(10); -- this won't work as we don't have insert permissions
use role sysadmin;
grant insert on table db1.schema1.table1 to role role1;
use role role1;
insert into db1.schema1.table1 (col) VALUES (6),(7),(8),(9),(10); -- the insert now works


-- Grant privileges to multiple objects
use role sysadmin;
create table db1.schema1.table2 (col int);
insert into db1.schema1.table2 (col) VALUES (1),(2),(3),(4),(5);
grant select on all tables in schema db1.schema1 to role role1; -- both tables will have select granted to role1
use role role1;
select * from db1.schema1.table1;
select * from db1.schema1.table2;


-- Grant privileges to future objects
use role securityadmin; -- note that future grants require securityadmin instead of sysadmin
grant select on future tables in schema db1.schema1 to role role1;
use role sysadmin;
create table db1.schema1.table3 (col int);
insert into db1.schema1.table3 (col) VALUES (1),(2),(3),(4),(5);
use role role1;
select * from db1.schema1.table3;


-- Clean-Up
use role accountadmin;
drop database if exists  db1;
drop role if exists role1;
drop user if exists user1;
drop warehouse if exists wh1;