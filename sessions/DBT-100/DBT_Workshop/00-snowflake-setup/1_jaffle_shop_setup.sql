use role sysadmin;

use warehouse load_wh;

create database dbt_workshop_raw;

create schema dbt_workshop_raw.jaffle_shop;

create schema dbt_workshop_raw.stripe;

create database dbt_workshop_analytics;

-- Create and populate customers table
create table dbt_workshop_raw.jaffle_shop.customers (
    id integer,
    first_name varchar,
    last_name varchar
);

copy into dbt_workshop_raw.jaffle_shop.customers (id, first_name, last_name)
from
    's3://dbt-tutorial-public/jaffle_shop_customers.csv' file_format = (
        type = 'CSV' field_delimiter = ',' skip_header = 1
    );

-- Create and populate orders table
create table dbt_workshop_raw.jaffle_shop.orders(
    id integer,
    user_id integer,
    order_date date,
    status varchar,
    _etl_loaded_at timestamp default current_timestamp
);

copy into dbt_workshop_raw.jaffle_shop.orders (id, user_id, order_date, status)
from
    's3://dbt-tutorial-public/jaffle_shop_orders.csv' file_format = (
        type = 'CSV' field_delimiter = ',' skip_header = 1
    );

-- Create and populate payment table
create table dbt_workshop_raw.stripe.payment (
    id integer,
    orderid integer,
    paymentmethod varchar,
    status varchar,
    amount integer,
    created date,
    _batched_at timestamp default current_timestamp
);

copy into dbt_workshop_raw.stripe.payment (
    id,
    orderid,
    paymentmethod,
    status,
    amount,
    created
)
from
    's3://dbt-tutorial-public/stripe_payments.csv' file_format = (
        type = 'CSV' field_delimiter = ',' skip_header = 1
    );
