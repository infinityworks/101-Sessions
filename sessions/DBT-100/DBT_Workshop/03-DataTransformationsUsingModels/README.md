
# Section 3: Data Transformations in dbt and Transformations DAG (Jaffle shop)

## Simple dbt Script

    ```sql
    with jaffle_payment_data as (
        select paymentmethod, sum(amount) from DBT_WORKSHOP_RAW.STRIPE.PAYMENT group by 1;
    )
    select * from jaffle_payment_data
    ```

## What are Models?

    -- select 3 models from the DBT course ( Ammar - to love )
    -- define a model

## Models Modularisation

    -- the `ref()` function

## Models Materialization?

    -- what are they: view, table, materialised table, (transient is out of scope)
    -- the recommendation is to start all models as views and then turn into table or materialised as needed
    -- when to use table or materialised table instead of view

## View - Table – Incremental Table

    -- the default materialisation (view)
    -- how to convert from view to table
    -- `dbt compile` command
    -- how is it stored in Snowflake
    -- how to configure the incremental table - using the config block
    -- he order precedence in the config lookup this_model.sql takes precedence over the dbt_project.yaml
    -- the main goal `dbt run` command and see it in snowflake

## dbt Code vs Stored Procedures

    -- clarify with Samer - is it dbt vs having standalone sql files (or specifically store procedures)

## Model Configurations (project file vs config block)

    -- from the 3 models above:
        -- convert 2 views into a table using the dbt_project.yaml
        -- convert one of the 2 views into a materialised table using the config block

## Sources and Src.yml File

    -- the `source()` function - refactor the model to use source
    -- The `source()` and `ref()` functions help create the lineage
    -- source freshness
