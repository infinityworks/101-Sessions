# Setup

## Generating the source data

1. Create a python virtual environment and install the required packages.

```
python3 -m venv .venv

pip3 install -r requirements.txt
```

2. To run the data generator use:

```
python3 ./input_data_generator/main_data_generator.py
```

concatonate the json data.

```
cat **/*.json > files.json
```

## Load the source data to Snowflake

1. Create the required database objects.

```sql
create database if not exists dbt_100;

create schema if not exists dbt_100.raw_data;

create table dbt_100.raw_data.products (product_id string, model  string, make string);

create table dbt_100.raw_data.customers (customer_id string, avg_visits_per_month int);

create table dbt_100.raw_data.transactions (transaction variant);

create or replace stage dbt_100.raw_data.raw_data_stage;
```

2. Upload the files to the stage. Snowsql will be required for this step.

```sql
use database dbt_100;
use schema raw_data;
put file://input_data/starter/customers.csv @raw_data_stage;
put file://input_data/starter/products.csv @raw_data_stage;
put file://input_data/starter/transactions/files.json @raw_data_stage;
```

3. Copy the data to snowflake.

```sql
use database dbt_100;
use schema raw_data;
copy into dbt_100.raw_data.customers from @raw_data_stage/customers.csv.gz file_format = ( type = csv skip_header = 1);
copy into dbt_100.raw_data.products from @raw_data_stage/products.csv.gz file_format = ( type = csv skip_header = 1);
copy into dbt_100.raw_data.transactions from @raw_data_stage/files.json.gz file_format = ( type = json);
```

## Creating the session Snowflake accounts and environments

1. Create a list of all users joining the session. Each list item is a dictionary and must contain the username field:

```python
{
    "username": "username"
}
```
The list should be called `session_users` and be defined in the `users.py` script.

2. Once the list has been finished, execute the python function:

```
python3 .setup/user_generator/main_user_generator.py
```

3. Spot check a couple users have their own user name, role, database and read access to the raw data.
