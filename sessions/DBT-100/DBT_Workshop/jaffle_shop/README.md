---
marp: true
---

# The Jaffle Shop Project

---

# Setting up the project

## Checking the installation

```bash
$ dbt --version
Core:
  - installed: 1.4.5
  - latest:    1.4.5 - Up to date!

Plugins:
  - snowflake: 1.4.2 - Up to date!
```

## Setting up the dbt project

```bash
dbt init
```

---

# Answer the prompted questions

```bash
Project: jaffleshop
Database: DBT_WORKSHOP
Account: INFINITYWORKSPARTNER.eu-west-1
User: <your snowflake username>
Authentication Type: password
Password: <your snowflake password>
role: DBT_WORKSHOP_ROLE
warehouse: TRANSFORMER
Default database: DBT_WORKSHOP
Default schema: ANALYTICS_<YOUR NAME>
threads: 1
Happy modeling!
```

---

# Test the connection

```bash
cd jaffleshop
dbt debug
```

---

# The Jaffle Shop

## Business Understanding

Jaffle Shop sells stuff and want to understand their customer purchase behaviours.

## Data Understanding - Entity Relationship Diagram (ERD)

![jaffle shop ERD](./assets/jaffle_shop_erd.png)

---

# Data Engineering and Analytics

# Step 1: Data exploration

```sql
select * from dbt_workshop.raw.customers;

select * from dbt_workshop.raw.orders;

select * from dbt_workshop.raw.payments;
```

---

## Step 2: Populating the staging schema

Content of `models/staging/stg_customers.sql` file

```sql
with raw_customer as (
     select * from dbt_workshop.raw.customers
),
transformed_customer as (
    select
        id as customer_id,
        first_name,
        last_name
    from raw_customer
)
select * from transformed_customer
```

---

Note: The default db and schema comes from the `profile.yml`

Adjust the models portion of `dbt_project.yml` file so it looks as below:

```yml
models:
  jaffleshop:
    +database: dbt_workshop
    staging:
      +schema: staging
```
---
Now time to run the model. In the terminal do 
`dbt run -s stg_customers`.

This runs the selected model.

To view what is actually run in snowflake, navigate to `target/run/jaffleshop/models/staging/stg_customers.sql`. Note the DDL that has been added to the top of the input.

---
Notes:

- This creates a schema named `ANALYTICS_<YOUR NAME>_staging`. Because we have `ANALYTICS_<YOUR NAME>` as the default schema
- This behaviour works well in development environments, to ensure each user has their own schema (and optionally own database etc) that they're working.
- This behaviour can be adjused using macros, to better suit production environments, different development patterns etc.

---

# Modularisation

Lets now start modularising by adding the sources file. Why:

- Makes it DRY (Don't Repeat Yourself)
- We can share the same definition of sources to all models by calling the **source()** function
- Later we'll see how we can extend the sources for testing and documentation and freshness

---

Content of the `models/staging/sources.yml` file

```yaml
version: 2

sources:
  - name: jaffleshop
    database: dbt_workshop  
    schema: raw  
    tables:
      - name: customers
```

---

With that let's refactor the customer model we've just created
`models/staging/stg_customers.sql`

```sql
with raw_customer as (
    select * from {{ source('jaffleshop', 'customers') }}
),
transformed_customer as (
    select
        id as customer_id,
        first_name,
        last_name
    from
        raw_customer
)
select * from transformed_customer
```

Notice how the compiled sql output hasn't changed!

---

Putting it all together, lets create the stg_orders model by following the steps bellow

1. Add `orders` to `models/staging/sources.yml` file
2. Create the `models/staging/stg_orders.sql` and apply the following transformation:
    - rename `id` to `order_id`
    - rename `user_id` to `customer_id`

---

Content of `models/staging/sources.yml`

```yaml
version: 2

sources:
  - name: jaffleshop
    database: dbt_workshop  
    schema: raw  
    tables:
      - name: customers
      - name: orders
```

---

Content of `models/staging/stg_orders.sql`

```sql
with raw_orders as (
    select * from  {{ source('jaffleshop', 'orders') }}
),
transformed_orders as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from
        raw_orders
)
select * from transformed_orders
```

---

# Exercise 1

Now using the same steps lets create the `models/staging/stg_payments.sql`

1. Add `payments` to `models/staging/sources.yml`
2. Create the `models/staging/stg_payments.sql` and apply the following transformation
    - rename `id` to `payment_id`
    - rename `orderid` to `order_id` for consistency

---

Content of `models/staging/sources.yml` file

```yml
version: 2

sources:
  - name: jaffleshop
    database: dbt_workshop  
    schema: raw  
    tables:
      - name: customers
      - name: orders
      - name: payments
```

---

Content of `models/staging/stg_payments.sql`

```sql
with raw_payments as (
    select * from {{ source('jaffleshop', 'payments') }}
),
transformed_payments as (
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod,
        status,
        amount,
        created
    from
          raw_payments
)
select * from transformed_payments
```

---

# Step 3: Populating the mart/warehouse

Now that we have out data prepared let's create the data warehouse/mart layer
This is where the Analytics Engineering role enters
This layer also know the presentation layer will be used to serve the BI/Reporting tools to be able to fulfil reporting requirements

**Question:** As a business analyst I want to know the top N customers based on their purchase habit

---

# Building the Mart

Lets build the mart/warehouse to answer to this and possibly other business question

Content of `models/mart/dim_customer.sql`. Seems daunting but lets break it down

> NOTE: Replace `<your_name>` to match your schema

--- 

```sql
with customers as (
    select
        customer_id,
        first_name,
        last_name
    from DBT_WORKSHOP.ANALYTICS_<your_name>_STAGING.STG_CUSTOMERS
),
orders as (
    select
        order_id,
        customer_id,
        order_date,
        status
    from DBT_WORKSHOP.ANALYTICS_<your_name>_STAGING.STG_ORDERS
),
customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by 1
),
final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders
    from customers
    left join customer_orders using (customer_id)
)
select * from final
```

---

# Exercise 2

Before building the models, please make sure the `dim_customer` is created in the `mart` schema.
> hint: Edit the `dbt_project.yml` file

---

Content of `dbt_project.yml` file

```yml
models:
  jaffleshop:
    +database: dbt_workshop
    staging:
      +schema: staging
    mart:
      +schema: mart
```

---

# Modularity Revisited

As with sources we also want to make models modular so we can reuse them elsewhere following:

- the DRY principle
- documentation
- testing
- lineage, we'll revisit this in the documentation section

## The ref() function

Instead of hardcoding the fully qualified name of the tables, let's refer to them in dbt by using the `ref()` function

---
Let's update `models/mart/dim_customer.sql` to use the `ref()` function
```sql
with customers as (
    select
        customer_id,
        first_name,
        last_name
    from {{ ref('stg_customers') }}
),
orders as (
    select
        order_id,
        customer_id,
        order_date,
        status
    from {{ ref('stg_orders') }}
)
...
```

---

# Recap

So far:

- We've create the staging layer
- We've created the mart layer
- We've applied modularisation
- What's next?
  - Materialisation
  - Testing
  - Documentation

---

## Materialisation

Materialisation determines how data is persisted in the data warehouse.

There are 4 types of materialisation:

- View (the default)
- Table
- Incremental Table
- Ephemeral - Not directly built into the database; Used to reduce clutter in models

So far all our model have been materialised as `views`, because that is the default.

---

The recommended approach is to leave them as views until we start noticing performance degradation, then table then Incremental Table.

Also we might need to materialise as table for auditing and compliance.

> Note: Apart from materialisations, model creation can also be enabled/disabled by using `+enabled: true | false` config.
> This is useful to when using external dbt packages

---

### How to configure materialisation?

There are 2 places where we can configure materialisation

1. The `dbt_project.yml` for a broader configuration
2. Individual model for a more granular configuration

---

**1** - Using the config file
Let's update the `dbt_project.yml` to look like this

```yml
models:
  jaffleshop:
    +database: dbt_workshop
    staging:
      +schema: staging
      +materialized: view
    mart:
      +schema: mart
      +materialized: table
```

---

**2** - Using the config block
Add the config block to the `models/mart/dim_customer.sql`

```sql
{{
    config(materialized='table')
}}

with customers as (
    select
        customer_id,
        first_name,
        last_name
    from {{ ref('stg_customers') }}
),
...
```

---

# Exercise 3

Modify your dbt project and make sure the following materialisation rules are applied:

1. All models created in `jaffleshop` must be views by default
2. All models in staging must be tables apart from `stg_customer` which must be view
3. All models in mart must be views apart from `dim_customer` which must be a table

---

# Incremental model

## The guiding principle when building dbt models

- **Start with a view**. When the view gets too long to query for end users
- **Make it a table**. When the table gets too long to build in your dbt Jobs
- **Build it incrementally**. That is, layer the data on in chunks as it comes in

---

# What are incremental models

- Models materialised as tables
- Models that only apply our transformation on new or updated rows
- The incremental models depend on the incremental strategy of the adapter (snowflake, bigquery, etc)

- We need **3 key things** in order to accomplish the above:
  - A filter to select just the new or updated records
  - A conditional block that wraps our filter and only applies it when we want it
  - configuration that tells dbt we want to build incrementally and helps apply the conditional filter when needed

---

Lets create an incremental model for the orders table

Content of `models/staging/incremental_orders.sql` file

```yaml
{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

select * from {{ source('jaffleshop', 'orders') }}

{% if is_incremental() %}

where
  _etl_loaded_at > (select max(_etl_loaded_at) from {{ this }})

{% endif %}
```

---

Let's explore the following commands to see what happens to the compiled sql.

```bash
dbt compile -s incremental_orders.sql
```

Now lets do run and compare again the result of the compiled version

```bash
dbt run -s incremental_orders.sql
dbt compile -s incremental_orders.sql
```

---

To rebuild the incremental model and all the downstream models we run the following commands

```bash
dbt run --full-refresh -s incremental_orders+
```

Useful source: https://docs.getdbt.com/guides/best-practices/materializations/4-incremental-models

---

# Testing

  > Tests are assertions you make about your models and other resources in your dbt project

There are 2 types of tests in dbt:

- Generic tests - Tests that can be reused over and over again
- Singular test -  An exact SQL that will return failing records

---

Let's add some generic tests by creating the following `models/staging/schema.yml` file

```yml
version: 2

models:
  - name: stg_orders
    columns:
      - name: order_id
        tests:
          - unique
          - not_null
```

---

We can also add singular tests in the `tests` directory
How does ths work?

```sql
-- if this query returns values, i.e. is not an empty set the test will fail
with result as (
    select 123 as col
)
-- fail
select * from result
-- the next line (uncomment) will make it pass because the result set will be empty
-- where col > 123   -- pass
```

---

### Exercises 4.1, 4.2 and 4.3

Let's complete `models/staging/schema.yml`:

**Exercise 4.1** - Add the following generic tests fixing any failing tests

```yml
      - name: status
        tests:
          - accepted_values:
              values: ['shipped', 'completed', 'return_pending', 'returned']
      - name: customer_id
        tests:
          - relationships:
              to: ref('stg_customers')
              field: id
```

Run the test by doing `dbt test -s stg_orders`

---

**Exercise 4.2** - Add the following singular test fixing any failing tests
Content of `tests/sum_of_orders_should_be_positive.sql` file

```sql
-- sum(number_of_orders) should not be negative
select
    customer_id,
    sum(number_of_orders) as number_of_orders
from {{ ref('dim_customer' )}}
group by 1
having sum(number_of_orders) > 0
```

Run `dbt test -s dim_customer`

---

# Exercise 4.3
Add a test to the `stg_orders` model table checking that the date is greater than 2017

---

# Source Revisited
## Source Freshness

- DBT allows us to check the freshness of the data sources
- This allows us to identify if the ingestion pipeline has failed
- We can make sure that the freshness checks pass before we build the models preventing stale models

# Exercise 5

To configure source freshness you need to update `models/staging/sources.yml` with the following code

```yml
version: 2

sources:
  - name: jaffleshop
    database: dbt_workshop
    schema: raw
    tables:
      - name: customers
      - name: orders
        freshness:
          warn_after: {count: 6, period: hour}
        loaded_at_field: _etl_loaded_at

      - name: payments
```

Now run the command `dbt source freshness` to check source freshness

---

#### Exercise 6

1. Turn this into an error and fix it so that it passes
> Hint: The period can be `minute`, `hour` or `day`

---

## Documentation

Why documenting:

- Information about your project
- Information about your data warehouse:

There are 2 ways to add documentation to you dbt project

1. By adding the `description` key and directly documenting the model
2. By using the `{{doc('key')}}`and pulling the actual doc from the configured location

---

1. Content of `models/staging/schema.yml` file

```yml
version: 2

models:
  - name: stg_orders
    description: "{{ doc('stg_models') }}"
    columns:
      - name: order_id
        description: "The id of the order after normalisation from raw to staging"
        tests:
          - unique
          - not_null
```

2. Content of `models/staging/docs.md`

```sql
{% docs stg_models %}
# Staged orders table
The `stg_orders` model is a populated from the raw `orders` table.

The following transformation are applied:
- `orderid` column reneamed to `order_id`
{% enddocs %}
```

---
Now that we've added all the documentation we can run the following self explanatory commands

```bash
dbt docs generate
dbt docs serve
```

Let's explore the site and see what was generated in terms of:

- models
- sources
- documentation
- tests
- lineage
- and so on

---

# Macros

Macros are a reusable block of SQL code.
They can be invoked within models, tests, or other macros.

The arguments can be column references, numbers, references to other models etc. 

Example:

Definition of macro in `macros/` directory:

```sql
{% macro my_macro(column1) %}
    do something with {{ column1 }}
{% endmacro %}
```

Use of macro in a model:

```sql
select
  {{ my_macro('column1') }}
```

---

# Exercise 7

Assume the payment amount in the `stg_payments` model is in cents, and it should be converted to dollars. There are hundreds of other columns where this same logic would need to be applied.

Create a macro to convert cents to dollars. It will take one argument, which will be the column name.

**Stretch** 

Give the macro a second argument, which will set the precison of the created numeric value, with a default value of 2. 
> Hint
The default value to a macro can be set like the below

```sql
{{ my_macro (argument1, argument2="default") }}
```
