-- ZERO COPY CLONE
use role accountadmin;
create database if not exists ZCP;
create schema if not exists ZCP.ZCP;

-- create sample data
create or replace table ZCP.ZCP.orders(
orderkey number(38,0),
custkey number(38,0),
orderstatus  varchar(1),
totalprice number (12,2),
orderdate date,
orderpriority varchar(15)
);

insert into ZCP.ZCP.orders (orderkey, custkey, orderstatus, totalprice, orderdate, orderpriority)
select o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority
from snowflake_sample_data.tpch_sf1.orders order by o_orderkey limit 100000;

-- let's check the data
select * from ZCP.ZCP.orders limit 100;

-- let's clone the whole schema
create schema ZCP.ZCP_clone clone ZCP.ZCP;

-- check if it is a zero copy clone. Both tables have same row count and bytes
select * from ZCP.information_schema.tables where table_name ='ORDERS';

-- let's delete some rows from the original table and check both tables again
delete from ZCP.ZCP.orders where orderkey <= 100000;
select * from ZCP.information_schema.tables where table_name ='ORDERS';

-- let's update some rows in the cloned table
update ZCP.ZCP_clone.orders set orderpriority = '1-URGENT' where orderkey < 100000 and orderpriority <> '1-URGENT';

-- let's check the active bytes. NOTE this table will refresh only every 90 minutes
select * from snowflake.account_usage.table_storage_metrics where table_catalog = 'ZCP' and table_name = 'ORDERS';

-- Clean-Up
drop database ZCP;