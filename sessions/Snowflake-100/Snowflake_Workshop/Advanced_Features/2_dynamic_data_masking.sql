use role accountadmin;
create database if not exists masking;
create schema if not exists masking.masking;

-- create some sample  data
create or replace table masking.masking.customers (customer_name string, customer_email string, first_purchase_date date, customer_region string);

insert into masking.masking.customers
values
('Marc Beale', 'Marc.Beale@gmail.com', '2020-02-03', 'North'),
('Lubna Begum', 'Lubna.Begum@yahoo.com', '2021-04-03', 'East'),
('Deborah Bogard', 'Deborah.Bogard@hotmail.com', '2022-04-03', 'South'),
('Daniel Stewart', 'Daniel.Stewart@gmail.com', '2022-10-23', 'West');

select * from masking.masking.customers ;


-- Column Level Masking.
-- I want create a role analyst to not be able to see the customer email

create or replace masking policy masking.masking.hashing_for_analyst_role as (val string) returns string ->
  case
    when current_role() in ('ANALYST') then sha2(val)
    else val
  end;

-- apply masking policy
alter table  masking.masking.customers modify column customer_email set masking policy masking.masking.hashing_for_analyst_role;

-- create role analyst with bare minimum permissions to query the table
create role if not exists ANALYST;
grant usage on database masking to role ANALYST;
grant usage on schema masking.masking to role ANALYST;
grant usage on warehouse compute_Wh to role ANALYST;
grant select on table masking.masking.customers to role ANALYST;
grant role ANALYST to user admin;

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
CREATE OR REPLACE TABLE masking.masking.region_roles_lookup (role string, region_name string);


INSERT INTO masking.masking.region_roles_lookup VALUES ('SOUTH_ANALYST', 'South'), ('NORTH_ANALYST', 'North'),('EAST_ANALYST', 'East'),('WEST_ANALYST', 'West');
select * from masking.masking.region_roles_lookup;

-- create policy to show only the rows that match the role based on the look up table
create or replace row access policy masking.masking.region_level_access as (region varchar) returns boolean ->
   current_role()='ACCOUNTADMIN'
      or exists (
            select 1 from masking.masking.region_roles_lookup
              where role = current_role()
                and region_name = region
          );

-- apply the policy
ALTER TABLE masking.masking.customers ADD ROW ACCESS POLICY masking.masking.region_level_access ON (customer_region);

-- create roles
create role if not exists north_analyst;
grant select on table masking.masking.customers to role north_analyst;
grant usage on database masking to role north_analyst;
grant usage on schema masking.masking to role north_analyst;
grant usage on warehouse compute_Wh to role north_analyst;
grant role north_analyst to user admin;

create role if not exists south_analyst;
grant usage on database masking to role south_analyst;
grant usage on schema masking.masking to role south_analyst;
grant usage on warehouse compute_Wh to role south_analyst;
grant select on table masking.masking.customers to role south_analyst;
grant role south_analyst to user admin;

create role if not exists east_analyst;
grant usage on database masking to role east_analyst;
grant usage on schema masking.masking to role east_analyst;
grant usage on warehouse compute_Wh to role east_analyst;
grant select on table masking.masking.customers to role east_analyst;
grant role east_analyst to user admin;

create role if not exists west_analyst;
grant usage on database masking to role west_analyst;
grant usage on schema masking.masking to role west_analyst;
grant usage on warehouse compute_Wh to role west_analyst;
grant select on table masking.masking.customers to role west_analyst;
grant role west_analyst to user admin;

-- check what rows they can see
select * from masking.masking.customers ;
use role east_analyst;
select * from masking.masking.customers ;
use role west_analyst;
select * from masking.masking.customers ;
use role south_analyst;
select * from masking.masking.customers ;
use role north_analyst;
select * from masking.masking.customers ;



-- Excercise
-- create sample data
use role accountadmin;
create or replace table masking.masking.customer_exercise like SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER;
insert into masking.masking.customer_exercise select * from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER where c_birth_country='UNITED STATES'limit 100;
insert into masking.masking.customer_exercise select * from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER where c_birth_country='UNITED KINGDOM'limit 100;
grant select on table masking.masking.customer_exercise to role analyst;
select * from masking.masking.customer_exercise;


-- Mask all PII data in the table "masking.masking.customer_exercise" for the role ANALYST.
-- start here:




-- Let the analyst role to only see customers born in the UK
use role accountadmin;
-- start here:

