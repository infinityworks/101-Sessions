-- TIME TRAVEL
use role accountadmin;
create database if not exists time_travel;
create schema if not exists time_travel.time_travel;

-- create sample data
create or replace table time_travel.time_travel.orders_3_day (
    o_orderkey number(38,0),
    o_custkey number(38,0),
    o_orderstatus varchar(1),
    o_totalprice number(12,2),
    o_orderdate date,
    o_orderpriority varchar(15),
    o_clerk varchar(15),
    o_shippriority number(38,0),
    o_comment varchar(79)
)
data_retention_time_in_days=3 -- note we specify here data retention
;

-- to see the retention period, use show tables sql
show tables like 'orders_3_day';

-- load data from a sample data set
insert into orders_3_day select * from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.ORDERS limit 1000000;

-- check the data
select count(*) from orders_3_day;
select *  from orders_3_day limit 100;
select distinct O_ORDERPRIORITY from orders_3_day order by O_ORDERPRIORITY;
select o_orderdate, count(*) from orders_3_day group by o_orderdate order by o_orderdate desc;

-- let's delete some data and save the query id and the number of rows deleted
delete from orders_3_day where o_orderdate < '1996-01-01';
-- record deleted: 
-- query-id: 
update orders_3_day set O_ORDERPRIORITY = '5-LOW' where O_ORDERPRIORITY = '4-NOT SPECIFIED';
-- records updated:
-- query-id: 

-- check the table
select count(*) from orders_3_day;
select distinct O_ORDERPRIORITY from orders_3_day;

-- time travel before
select count(*) from orders_3_day before(statement => 'query_id_1');

select count(*) from orders_3_day before(statement => 'query_id_2');
select distinct O_ORDERPRIORITY from orders_3_day before(statement => 'query_id_2');

-- time travel at
select count(*) from orders_3_day at(statement => 'query_id_1');

-- not exist query approach. Use the first query id
-- Gives all the records that have been deleted by the first query
select * from orders_3_day before(statement => 'query_id_1') tt_past
where not exists
(select 1
          from orders_3_day tt_now
          where tt_past.O_ORDERKEY = tt_now.O_ORDERKEY);

-- you can check your query ids here
select *
from table(information_schema.query_history())
where end_time > current_time() -INTERVAL '5 minutes' order by start_time desc;

-- if you don't know the query id, you can select based on a time offset in seconds
select count(*) from orders_3_day at(offset => -300);

-- The following query selects historical data from a table as of the date and time represented by the specified timestamp:
select count(*) from orders_3_day at(timestamp => '2023-11-29 05:55:50.494 -0800'::timestamp_tz);


-- with time travel you can also "undrop" tables
drop table orders_3_day;
undrop table orders_3_day;

use role accountadmin;
use SNOWFLAKE_SAMPLE_DATA;


-- Exercise
-- We have an item table that shows the current price for each item. Price history is not stored.
-- We want to show the full price history for each item
--+---------+-------+-------------------------+
--| ITEM_ID | PRICE | UPDATED_AT              |
--+---------+-------+-------------------------+
--| 1       | 9.99  | 2023-03-09 06:49:27.058 |
--+---------+-------+-------------------------+
--| 1       | 7.99  | 2023-03-09 06:49:27.986 |
--+---------+-------+-------------------------+
--| 1       | 8.99  | 2023-03-09 06:49:29.092 |
--+---------+-------+-------------------------+
--| 1       | 12.99 | 2023-03-09 06:49:29.572 |
--+---------+-------+-------------------------+
--| 2       | 4.99  | 2023-03-09 06:49:27.058 |
--+---------+-------+-------------------------+
--| 2       | 2.99  | 2023-03-09 06:49:27.986 |
--+---------+-------+-------------------------+
--| 2       | 4.99  | 2023-03-09 06:49:29.092 |
--+---------+-------+-------------------------+
--| 2       | 8.99  | 2023-03-09 06:49:29.572 |
--+---------+-------+-------------------------+


create or replace table time_travel.time_travel.item_price (
item_id int,
price FLOAT,
updated_at timestamp
);

insert into time_travel.time_travel.item_price (item_id, price, updated_at) values(1, 9.99, current_timestamp),(2, 4.99, current_timestamp);
update time_travel.time_travel.item_price set price=(CASE WHEN item_id = 1 THEN 7.99 ELSE 2.99 END), updated_at=current_timestamp ;
update time_travel.time_travel.item_price set price=(CASE WHEN item_id = 1 THEN 8.99 ELSE 4.99 END), updated_at=current_timestamp ;
update time_travel.time_travel.item_price set price=(CASE WHEN item_id = 1 THEN 12.99 ELSE 8.99 END), updated_at=current_timestamp ;
select * from time_travel.time_travel.item_price;

-- start here

-- Look at previous query ids with
-- select *
-- from table(information_schema.query_history())
-- where end_time > current_time() -INTERVAL '5 minutes'order by start_time desc;


-- replace {query_id} with the query id string
select * from time_travel.time_travel.item_price at(statement => {query_id})
union all
select * from time_travel.time_travel.item_price at(statement => {query_id})
union all
select * from time_travel.time_travel.item_price at(statement => {query_id})
union all
select * from time_travel.time_travel.item_price at(statement => {query_id})
order by item_id, updated_at;
