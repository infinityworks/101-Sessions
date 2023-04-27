use role sysadmin;
use warehouse load_wh;

create database dbt_workshop;
create schema dbt_workshop.raw;

-- Create and populate the customers table
create table dbt_workshop.raw.customers (
    id integer,
    first_name varchar,
    last_name varchar
);

copy into dbt_workshop.raw.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 

-- Create and populate the orders table

create table dbt_workshop.raw.orders(
    id integer,
    user_id integer,
    order_date date,
    status varchar,
    _etl_loaded_at timestamp default current_timestamp
);

copy into dbt_workshop.raw.orders (id, user_id, order_date, status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );

-- Create and populate payment table
create table dbt_workshop.raw.payment (
    id integer,
    orderid integer,
    paymentmethod varchar,
    status varchar,
    amount integer,
    created date,
    _batched_at timestamp default current_timestamp
);

copy into dbt_workshop.raw.payment (id, orderid, paymentmethod, status, amount, created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );
