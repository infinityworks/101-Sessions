-- ROLES AND USERS

-- Creation of a role:
use role securityadmin; -- By default, only accountadmin and securityadmin can create roles. Securityadmin is the recommended role to be used to create roles
create role role1;
grant role role1 to user andrea;

use role sysadmin; -- Trying creating a role with sysadmin will trigger an error i.e. Insufficient privileges to operate on account
create role role1;


-- Creation of a user
use role useradmin; -- USERADMIN is the recommended role to be used to create users
create user user1;

grant role role1 to user user1; -- the below won't work as USERADMIN does not have privileges over role1. Grant not executed: Insufficient privileges.

use role securityadmin; -- need to switch back to SECURITYADMIN again
grant role role1 to user user1;


-- Let's check what we have:
show roles like 'role1'; -- role1 existes and is owned by SECURITYADMIN. The OWNERSHIP privilege is granted to and by SECURITYADMIN
show grants on role role1;

show users like 'user1'; -- user1 exists and is owned by USERADMIN. The OWNERSHIP privilege is granted to and by USERADMIN
show grants on user user1;

show grants of role role1; -- role1 has been granted to a user i.e. user1

show grants to user user1; -- user1 has the grant to role1



-- SECURABLE OBJECTS

-- Create Objects
use role sysadmin; -- SYSADMIN is the default role to use to create objects
create database db1;

use role securityadmin; -- the below won't work as SECURITYADMIN does not have privileges to create databses
create database db1;

show databases like 'db1'; -- let's check what we have. The owner of the object is SYSADMIN. Note, there is no show grants to database as "grants to" is for roles and users
show grants on database db1;

grant ownership on database db1 to role role1; -- Let's change the ownership of the database
show databases like 'db1'; -- this will produce no result as SYSADMIN has lost ownership of that database

use role role1;
show databases like 'db1';
grant ownership on database db1 to role sysadmin; -- granting back the ownership to SYSADMIN will make it visible again.
show databases like 'db1';



-- PRIVILEGES

-- create some objctes
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
use role sysadmin;

grant usage on database db1 to role role1;
grant usage on warehouse wh1 to role role1;
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



-- ROLE GRANTS AND PRIVILEGES INHERITANCE
use role sysadmin;
grant create table on schema db1.schema1 to role1; -- grant create tables to role1
use role role1;
create table db1.schema1.table4 (col int);
insert into db1.schema1.table4 (col) VALUES (1),(2),(3),(4),(5);

show tables like 'table%';

use role sysadmin;
show tables like 'table%'; -- SYSADMIN cannot see the table even though it is the owner of the schema

use role securityadmin;
grant role role1 to role sysadmin;
use role sysadmin;
show tables like 'table%';
show grants on role role1;

-- CLen-Up
use role accountadmin;
drop role role1;
drop user user1;
drop warehouse wh1;
