-- ADVANCED FEATURES
use role sysadmin;
create database advanced_features;



-- TIME TRAVEL
create schema time_travel;
create or replace table tt_3_days (
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
data_retention_time_in_days=3
;


-- desc table does not show time travel period
desc table tt_3_days;

-- to see the retention period, you have to use show tables sql
show tables like 'tt_3_days';

-- alternatively, you can see it via information schema
select * from "ADVANCED_FEATURES"."INFORMATION_SCHEMA"."TABLES"
where table_name = 'TT_3_DAYS';


-- load data from a sample data set
insert into tt_3_days select * from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.ORDERS limit 1000000;

-- check the data
select count(*) from tt_3_days;

-- see first few records
select *  from tt_3_days limit 100;
select distinct O_ORDERPRIORITY from tt_3_days;
select o_orderdate, count(*) from tt_3_days group by o_orderdate order by o_orderdate desc;



delete from tt_3_days where o_orderdate < '1996-01-01';
-- record deleted: 521,792
-- query-id: 01aab823-0000-4ff2-0000-f4290003608a


update tt_3_days set O_ORDERPRIORITY = '5-LOW' where O_ORDERPRIORITY = '4-NOT SPECIFIED';
-- records updated:95,598
-- query-id: 01aab825-0000-4ffb-0000-f42900037036

-- check the table
select count(*) from tt_3_days;
select distinct O_ORDERPRIORITY from tt_3_days;

-- time travel before
select count(*) from tt_3_days before(statement => '01aab823-0000-4ff2-0000-f4290003608a');
select count(*) from tt_3_days before(statement => '01aab825-0000-4ffb-0000-f42900037036');
select distinct O_ORDERPRIORITY from tt_3_days before(statement => '01aab825-0000-4ffb-0000-f42900037036');

-- time travel at
select count(*) from tt_3_days at(statement => '01aab823-0000-4ff2-0000-f4290003608a');


-- not exist query approach
select * from tt_3_days before(statement => '01aab823-0000-4ff2-0000-f4290003608a') tt_past
where not exists
(select 1
          from tt_3_days tt_now
          where tt_past.O_ORDERKEY = tt_now.O_ORDERKEY);


select count(*) from tt_3_days at(offset => -1400);

-- The following query selects historical data from a table as of the date and time represented by the specified timestamp:
select count(*) from tt_3_days at(timestamp => 'Sun, 4 Mar 2021 11:10:03.389 -0800'::timestamp_tz); -- 100000


drop table tt_3_days;

undrop table tt_3_days;



-- ZERO COPY CLONE
use role sysadmin;
create or replace schema zero_copy_clone;
create or replace table advanced_features.zero_copy_clone.simple_order(
orderkey number(38,0),
custkey number(38,0),
orderstatus  varchar(1),
totalprice number (12,2),
orderdate date,
orderpriority varchar(15)
);

insert into advanced_features.zero_copy_clone.simple_order (orderkey, custkey, orderstatus, totalprice, orderdate, orderpriority)
select o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority
from snowflake_sample_data.tpch_sf1.orders order by o_orderkey limit 100000;

select * from advanced_features.zero_copy_clone.simple_order;


delete from advanced_features.zero_copy_clone.simple_order where orderkey <= 100;

create table advanced_features.zero_copy_clone.simple_order_clone clone simple_order;

select count(*) from advanced_features.zero_copy_clone.simple_order_clone;
select count(*) from advanced_features.zero_copy_clone.simple_order;

-- check if it is a zero compy clone. Both tables have same row count and bytes
select * from advanced_features.information_schema.tables where table_name like 'SIMPLE_ORDER%';

-- check the different size
use role ACCOUNTADMIN;
use database advanced_features;
select * from snowflake.account_usage.table_storage_metrics where table_schema = 'ZERO_COPY_CLONE';



use role sysadmin;
insert into advanced_features.zero_copy_clone.simple_order (orderkey, custkey, orderstatus, totalprice, orderdate, orderpriority)
select o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority
from snowflake_sample_data.tpch_sf1.orders order by o_orderkey limit 1000;

update advanced_features.zero_copy_clone.simple_order_clone set orderpriority = '1-URGENT' where orderkey < 100000 and orderpriority <> '1-URGENT';

select * from advanced_features.information_schema.tables where table_name like 'SIMPLE_ORDER%';


-- PARSING SEMI-STRUCTURED DATA

use role sysadmin;
create schema advanced_features.semi_structured;
CREATE OR REPLACE TABLE advanced_features.semi_structured.car_sales
(
  src variant
)
AS
SELECT PARSE_JSON(column1) AS src
FROM VALUES
('{
    "date" : "2017-04-28",
    "dealership" : "Valley View Auto Sales",
    "salesperson" : {
      "id": "55",
      "name": "Frank Beasley"
    },
    "customer" : [
      {"name": "Joyce Ridgely", "phone": "16504378889", "address": "San Francisco, CA"}
    ],
    "vehicle" : [
      {"make": "Honda", "model": "Civic", "year": "2017", "price": "20275", "extras":["ext warranty", "paint protection"]}
    ]
}'),
('{
    "date" : "2017-04-28",
    "dealership" : "Tindel Toyota",
    "salesperson" : {
      "id": "274",
      "name": "Greg Northrup"
    },
    "customer" : [
      {"name": "Bradley Greenbloom", "phone": "12127593751", "address": "New York, NY"}
    ],
    "vehicle" : [
      {"make": "Toyota", "model": "Camry", "year": "2017", "price": "23500", "extras":["ext warranty", "rust proofing", "fabric protection"]}
    ]
}') v;

select * from advanced_features.semi_structured.car_sales;


select src:dealership from advanced_features.semi_structured.car_sales; --you can get any first level element inserting a colon between the VARIANT column and the first element <column>:<level1_element>

select src:salesperson.name from advanced_features.semi_structured.car_sales; -- you can traverse the path of a semi-structured object using the dot notation

select src['salesperson']['name'] from advanced_features.semi_structured.car_sales; -- you can achieve the same using the bracket notation


SELECT src:customer[0].name, src:vehicle[0] from advanced_features.semi_structured.car_sales; -- retrieve a single instance of a repeating element

SELECT src:customer[0].name, src:vehicle[0].price from advanced_features.semi_structured.car_sales; -- you can further traverse the path and the price value. Note that the price is a STRING

SELECT src:customer[0].name, src:vehicle[0].price::NUMBER from advanced_features.semi_structured.car_sales; -- values in a VARIANT column are by default surrounded by double quotes. Using a double colon :: you can cast these values


SELECT
  value:name::string as "Customer Name",
  value:address::string as "Address"
  FROM
    advanced_features.semi_structured.car_sales
  , LATERAL FLATTEN(INPUT => SRC:customer); -- you can produce a laterla view of a VARIANT column with the FLATTEN function. The function returns a row for each object, and the LATERAL modifier joins the data with any information outside of the object.

SELECT
  vm.value:make::string as make,
  vm.value:model::string as model,
  ve.value::string as "Extras Purchased"
  FROM
    advanced_features.semi_structured.car_sales
    , LATERAL FLATTEN(INPUT => SRC:vehicle) vm
    , LATERAL FLATTEN(INPUT => vm.value:extras) ve; -- you can nest the FLATTEN function to access deeper elements


CREATE OR replace TABLE advanced_features.semi_structured.colors (v variant);

INSERT INTO
   advanced_features.semi_structured.colors
   SELECT
      parse_json(column1) AS v
   FROM
   VALUES
     ('[{r:255,g:12,b:0},{r:0,g:255,b:0},{r:0,g:0,b:255}]'),
     ('[{c:0,m:1,y:1,k:0},{c:1,m:0,y:1,k:0},{c:1,m:1,y:0,k:0}]')
    v;

select * from  advanced_features.semi_structured.colors;
-- you can use the GET function to access any element of an array
SELECT *
, GET(v, 0) -- get the first element
, GET(v, ARRAY_SIZE(v)-1) -- get the last element
FROM advanced_features.semi_structured.colors;


-- DYNAMIC DATA MASKING

use role sysadmin;
create schema advanced_features.masking;
create or replace table advanced_features.masking.customers (customer_name string, customer_email string, first_purchase_date date, customer_region string);

insert into advanced_features.masking.customers
values
('Marc Beale', 'Marc.Beale@gmail.com', '2020-02-03', 'North'),
('Lubna Begum', 'Lubna.Begum@yahoo.com', '2021-04-03', 'East'),
('Deborah Bogard', 'Deborah.Bogard@hotmail.com', '2022-04-03', 'South'),
('Daniel Stewart', 'Daniel.Stewart@gmail.com', '2022-10-23', 'West');

select * from advanced_features.masking.customers ;


use role securityadmin;
GRANT CREATE MASKING POLICY on SCHEMA advanced_features.masking to ROLE SYSADMIN;
GRANT APPLY MASKING POLICY on ACCOUNT to ROLE SYSADMIN;

create role ANALYST;
grant select on table advanced_features.masking.customers to role ANALYST;
grant role analyst to user andrea;


-- create Masking Policy


use role sysadmin;
drop masking policy advanced_features.masking.email_mask;

create or replace masking policy advanced_features.masking.email_mask as (val string) returns string ->
  case
    when current_role() in ('ANALYST') then sha2(val)
    else val
  end;

use role sysadmin;


alter table  advanced_features.masking.customers modify column customer_email set masking policy email_mask;


use role ANALYST;
select * from advanced_features.masking.customers;
use role sysadmin;
select * from advanced_features.masking.customers;

-- row level masking policy

use role securityadmin;

create role if not exists country_analyst;
grant usage on database advanced_features to role country_analyst;
grant usage on schema advanced_features.masking to role country_analyst;
grant usage on warehouse compute_Wh to role country_analyst;
grant select on table advanced_features.masking.customers to role country_analyst;
grant role country_analyst to user andrea;

create role if not exists north_analyst;
grant select on table advanced_features.masking.customers to role north_analyst;
grant usage on database advanced_features to role north_analyst;
grant usage on schema advanced_features.masking to role north_analyst;
grant usage on warehouse compute_Wh to role north_analyst;
grant role north_analyst to user andrea;

create role if not exists south_analyst;
grant usage on database advanced_features to role south_analyst;
grant usage on schema advanced_features.masking to role south_analyst;
grant usage on warehouse compute_Wh to role south_analyst;
grant select on table advanced_features.masking.customers to role south_analyst;
grant role south_analyst to user andrea;

create role if not exists east_analyst;
grant usage on database advanced_features to role east_analyst;
grant usage on schema advanced_features.masking to role east_analyst;
grant usage on warehouse compute_Wh to role east_analyst;
grant select on table advanced_features.masking.customers to role east_analyst;
grant role east_analyst to user andrea;

create role if not exists west_analyst;
grant usage on database advanced_features to role west_analyst;
grant usage on schema advanced_features.masking to role west_analyst;
grant usage on warehouse compute_Wh to role west_analyst;
grant select on table advanced_features.masking.customers to role west_analyst;
grant role west_analyst to user andrea;



use role sysadmin;
CREATE OR REPLACE TABLE advanced_features.masking.region_roles_lookup (role string, region_name string);


INSERT INTO advanced_features.masking.region_roles_lookup VALUES ('SOUTH_ANALYST', 'South'), ('NORTH_ANALYST', 'North'),('EAST_ANALYST', 'East'),('WEST_ANALYST', 'West');
select * from advanced_features.masking.region_roles_lookup;


create or replace row access policy region_level_access as (region varchar) returns boolean ->
   current_role()='SYSADMIN'
      or exists (
            select 1 from advanced_features.masking.region_roles_lookup
              where role = current_role()
                and region_name = region
          );


ALTER TABLE advanced_features.masking.customers ADD ROW ACCESS POLICY region_level_access ON (customer_region);


select * from advanced_features.masking.customers ;
use role east_analyst;
select * from advanced_features.masking.customers ;
use role west_analyst;
select * from advanced_features.masking.customers ;
use role south_analyst;
select * from advanced_features.masking.customers ;
use role north_analyst;
select * from advanced_features.masking.customers ;
