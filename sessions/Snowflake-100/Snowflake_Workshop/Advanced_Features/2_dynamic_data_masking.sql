use role accountadmin;
create database if not exists masking;
create schema if not exists masking.masking;

-- create some sample  data
create or replace table customers (customer_name string, customer_email string, first_purchase_date date, customer_region string);

insert into customers
values
('Marc Beale', 'Marc.Beale@gmail.com', '2020-02-03', 'North'),
('Lubna Begum', 'Lubna.Begum@yahoo.com', '2021-04-03', 'North'),
('Deborah Bogard', 'Deborah.Bogard@hotmail.com', '2022-04-03', 'South'),
('Daniel Stewart', 'Daniel.Stewart@gmail.com', '2022-10-23', 'South');

select * from customers ;


-- Column Level Masking.
-- I want create a role analyst to not be able to see the customer email

create or replace masking policy hashing_for_analyst_role as (val string) returns string ->
  case
    when current_role() in ('ANALYST') then sha2(val)
    else val
  end;

-- apply masking policy
alter table customers modify column customer_email set masking policy hashing_for_analyst_role;

-- create role analyst with bare minimum permissions to query the table
create role if not exists ANALYST;
grant usage on database masking to role ANALYST;
grant usage on schema masking.masking to role ANALYST;
grant usage on warehouse compute_wh to role ANALYST;
grant select on table customers to role ANALYST;
grant role ANALYST to role sysadmin;

-- analyst role will see the email hashed
use role ANALYST;
select * from masking.masking.customers;
-- accountadmin role will see the values normally
use role accountadmin;
select * from masking.masking.customers;

-- Row Level Masking
-- I want to limit the rows that certain roles can access based on values in a column

-- I need a lookup table to associate roles and values in my table
use role accountadmin;
CREATE OR REPLACE TABLE region_roles_lookup (role string, region_name string);


INSERT INTO region_roles_lookup VALUES ('SOUTH_ANALYST', 'South'), ('NORTH_ANALYST', 'North');
select * from region_roles_lookup;

-- create policy to show only the rows that match the role based on the look up table
create or replace row access policy region_level_access as (region varchar) returns boolean ->
   current_role()='ACCOUNTADMIN'
      or exists (
            select 1 from region_roles_lookup
              where role = current_role()
                and region_name = region
          );

-- apply the policy
ALTER TABLE customers ADD ROW ACCESS POLICY region_level_access ON (customer_region);

-- create roles
create role if not exists north_analyst;
grant select on table customers to role north_analyst;
grant usage on database masking to role north_analyst;
grant usage on schema masking.masking to role north_analyst;
grant usage on warehouse compute_Wh to role north_analyst;
grant role north_analyst to role sysadmin;

create role if not exists south_analyst;
grant usage on database masking to role south_analyst;
grant usage on schema masking.masking to role south_analyst;
grant usage on warehouse compute_Wh to role south_analyst;
grant select on table customers to role south_analyst;
grant role south_analyst to role sysadmin;


-- check what rows they can see
select * from customers;
use role south_analyst;
select * from customers;
use role north_analyst;
select * from customers;

-- Exercise
-- create sample data
use role accountadmin;
create or replace table customer_exercise like SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER;
insert into customer_exercise select * from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER where c_birth_country='UNITED STATES'limit 100;
insert into customer_exercise select * from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER where c_birth_country='UNITED KINGDOM'limit 100;
grant select on table customer_exercise to role analyst;
select * from customer_exercise;


-- EXERCISE 1 Mask the name and email data in the table "customer_exercise" for the role ANALYST.
-- Note, the same masking policy can be used on more than one column
-- start here:
-- start here:

alter table  customer_exercise modify column c_first_name set masking policy hashing_for_analyst_role; -- apply the masking policy to a column
-- apply the msame masking policy to the other columns

-- verify if it works
use role analyst;
select * from customer_exercise;



-- EXERCISE 2 Let the analyst role to only see customers born in the UK
use role accountadmin;
-- start here:

CREATE OR REPLACE TABLE country_lookup (role string, country_name string);

INSERT INTO country_lookup VALUES ('ANALYST', 'UNITED KINGDOM');
select * from country_lookup;


create or replace row access policy country_level_access as (country varchar) returns boolean ->
--{look at the row level policy created earlier}


ALTER TABLE customer_exercise ADD ROW ACCESS POLICY country_level_access ON (c_birth_country);

-- verify if it works
use role analyst;
select * from customer_exercise;