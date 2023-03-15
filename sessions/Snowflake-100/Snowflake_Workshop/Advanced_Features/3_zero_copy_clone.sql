-- ZERO COPY CLONE
use role accountadmin;
create database if not exists ZCC;
create schema if not exists ZCC.ZCC;

-- create sample data
create or replace table ZCC.ZCC.orders(
orderkey number(38,0),
custkey number(38,0),
orderstatus  varchar(1),
totalprice number (12,2),
orderdate date,
orderpriority varchar(15)
);

insert into ZCC.ZCC.orders (orderkey, custkey, orderstatus, totalprice, orderdate, orderpriority)
select o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority
from snowflake_sample_data.tpch_sf1.orders order by o_orderkey limit 100000;

-- let's check the data
select * from ZCC.ZCC.orders limit 100;

-- let's clone the whole schema
create schema ZCC.ZCC_clone clone ZCC.ZCC;

-- check if it is a zero copy clone. Both tables have same row count and bytes
select * from ZCC.information_schema.tables where table_name ='ORDERS';

-- let's delete some rows from the original table and check both tables again
delete from ZCC.ZCC.orders where orderkey <= 100000;
select * from ZCC.information_schema.tables where table_name ='ORDERS';

-- let's update some rows in the cloned table
update ZCC.ZCC_clone.orders set orderpriority = '1-URGENT' where orderkey < 100 and orderpriority <> '1-URGENT';

-- let's check the active bytes. NOTE this table will refresh only every 90 minutes
select * from snowflake.account_usage.table_storage_metrics where table_catalog = 'ZCC' and table_name = 'ORDERS';

-- let's see how it behaves with transient tables
create transient table ZCC.ZCC.transient_table (col int);
-- creating a permanent table from a transient table won't work
create table ZCC.ZCC.transient_table_clone clone ZCC.ZCC.transient_table;
-- it can be created as a transient table
create transient table ZCC.ZCC.transient_table_clone clone ZCC.ZCC.transient_table;

-- let's see how it behaves with temporary tables
create temporary table ZCC.ZCC.temporary_table (col int);
-- creating a permanent table from a temporary table won't work
create table ZCC.ZCC.temporary_table_clone clone ZCC.ZCC.temporary_table;
-- it can be created as a transient table
create transient table ZCC.ZCC.transient_table_clone clone ZCC.ZCC.transient_table;


-- Clean-Up
drop database ZCC;