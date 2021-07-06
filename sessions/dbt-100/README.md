# dbt 100
github repo for the dbt 100 session

## Introduction

Welcome to the DBT 100 session. This session will guide you through the installation and setup of dbt, initialising a dbt project, setting up data sources and deploying your first models.

## Setup

If you are running the dbt_100 session on a new Snowflake account, the instructions to set everything up are [here.](setup/setup.md)

## Session

### Environment setup

Create a virtual environment and install dbt

```
python3 -m venv .venv

source .venv/bin/activate

pip3 install dbt
```
### Initialise a dbt project

```
dbt init project_name
```

Update the project name in the `dbt_project.yml`. This is done in the `name` field and also underneath the `models` field. 

Information about the dbt project can be found [here](dbt_project.md).

### The dbt profile

When initializing a dbt project for the first time a dbt profile will be created:

```
# Mac
/users/user/.dbt

# Windows
Users/Admin/.dbt
```

A dbt profile specifies the warehouse you intent to work with. More information on the dbt profile can be found [here](dbt_profile.md)

### Configure a dbt profile for Snowflake

In the dbt profile file, add an additional configuration called `snowflake`.

```
snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: snowflake_account
      user: username
      password: password
      role: role
      database: database
      warehouse: warehouse
      schema: schema
      threads: [1 of more]
      client_session_keep_alive: False
      query_tag: anything
```

The account is the snowflake account including the aws region.
The role, database, warehouse and schema are all the default object you wish to use with dbt.
Threads is the number of concurrent models dbt can deploy in parallel
The client_session_keep_alive flag issues a periodic `select` statement to keep the DB connection open during long-running queries (> 4 hours).
The query tag is a value which you use to tag queries.

### Linking a dbt profile with your dbt project

The profile configuration in the `dbt_project.yml` file must align with the profile in your `profiles.yml` file.

```
profile: 'snowflake'
```
Once linked to a project, dbt will execute commands on the warehouse configured in the given profile and targets.

### Testing your connection

In your dbt project directory, execute the following command:

```
dbt debug
```
If successful, the connection test should come back:

```
OK connection ok
```

### Deploy your first models

By default, the dbt project comes with two example models. To deploy these models in your project, execute the following command from you project directory:

```
├── models
│   └── example
│       ├── my_first_dbt_model.sql
│       ├── my_second_dbt_model.sql
│       └── schema.yml
```

```
dbt run
```

### Sources

Sources make it possible to name and describe the data loaded into your warehouse by ETL tools.

You can select from source tables in your models using the `{{ source( )}}` function.

The default location of your source tables is in the models directory. They are defined as `yml` files.

### Defining your sources

In the models directory create a new folder called dbt_100 and create an empty yml file named `schema.yml`. This is where the sources will be defined.

```
mkdir models/dbt_100
touch models/dbt_100/schema.yml
```
Inside the schema.yml add the following lines:
```
version: 2

sources:
  - name: dbt_100
    database: dbt_100
    schema: raw_data
    tables:
      - name: customers
      - name: products
      - name: transactions
```

### Writing your first models

To reference a `source` in a dbt model the `{{ source ()}}` function must be used. The function takes two arguments, the source name and table name.

#### products.sql

```sql
with products as (
    select * from
    {{ source ('dbt_100', 'products')}}
)
select * from products
```

#### transactions.sql

```sql
with transactions as (
SELECT
    transaction:CUSTOMER_ID::string as customer_id,
    transaction:DATE_OF_SESSION::timestamp as session_timestamp,
    VALUE:PRODUCT_ID::string as product_id,
    VALUE:PRICE::integer as price
FROM  {{ source ('dbt_100', 'transactions')}},
   lateral flatten(input =>  TRANSACTION, path => 'PRODUCTS_VIEWED')
)
select * from transactions
```

### Referencing models

To reference models in other models the `{{ ref() }}` function must be used.
The ref function takes a single argument, the model name.

#### product_transactions.sql

```sql
with transactions as (
    select * from {{ ref('transactions') }}
), products as (
    select * from {{ ref('products') }}
)
select
    t.customer_id,
    t.session_timestamp,
    t.product_id,
    t.price,
    p.model,
    p.make
from transactions t
join products p
on t.product_id = p.product_id
```

### Documenting your results

dbt provides a way to generate documentation for your dbt project and render it as a website. The documentation for your project includes:

* Information about your project: including model code, a DAG of your project, any tests you've added to a column, and more.
* Information about your data warehouse: including column data types, and table sizes.
* This information is generated by running queries against the information schema.

To generate a site run the following commands:

```
dbt docs generate

dbt docs serve
```

## Author

Cinch data squad



