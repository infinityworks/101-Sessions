# Unloading data from Snowflake [docs](https://docs.snowflake.com/en/user-guide/data-unload-snowflake.html)]

A stage is needed to unload data locally.

Use the following to create a stage which will allow us to unload the data using the CLI.

    USE DATABASE RAW_DATA;
    USE SCHEMA SALES;
    create or replace stage my_unload_stage file_format = (TYPE='JSON' compression=none);

Copy a table's data into the stage:

    copy into @my_unload_stage/unload/ from "RAW_DATA"."SALES"."TRANSACTIONS"

Show which files have been prepared for unloading:

    list @my_unload_stage;

Change to the SnowSQL CLI and run:

    get @my_unload_stage/unload/data_0_0_0.json file:///path/to/export/;

## Unloading with a user stage
You can copy directly into your own user stage bypassing the need to create one

    copy into @~/unload/ from "RAW_DATA"."SALES"."TRANSACTIONS" file_format = (TYPE= 'JSON' compression = none);

    get @~/unload/data_0_0_0.json  file:///path/to/export/;
