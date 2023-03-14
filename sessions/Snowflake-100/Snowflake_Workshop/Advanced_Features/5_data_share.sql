-- DATA SHARE
use role accountadmin;

-- create some dummy db, schema and table to share
create database if not exists  share_db;
create schema if not exists share_db.share_schema;
create or replace table share_db.share_schema.table1 (col int);
insert into share_db.share_schema.table1 (col) values (1),(2),(3),(4),(5);

-- create a share
create share if not exists "SF_WORKSHOP";

-- grant usage on database. Note, it is similar to granting permissions to a role
grant usage on database share_db to share SF_WORKSHOP;

-- grant usage on schema.
grant usage on schema share_db.share_schema to share SF_WORKSHOP;

-- grant select on the table.
grant select on table share_db.share_schema.table1 to share SF_WORKSHOP;

-- Add accounts to this share
ALTER SHARE SF_WORKSHOP ADD ACCOUNTS = "CT90700";

-- Clean-Up
drop share if exists SF_WORKSHOP;
drop database if exists share_db;

