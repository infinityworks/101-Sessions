# Loading data via a stage [[docs](https://docs.snowflake.com/en/user-guide/data-load-internal-tutorial-stage-data-files.html)]

To load data into the transactions table, we can use Snowflake's in-built table stage. A stage is a temporary holding area for data which we'll use to load our files into Snowflake.


First we need data to load. We'll generate the data from another [repo](https://github.com/infinityworks/iw-data-test-python). Clone this repo and follow the installation instructions:

    git clone https://github.com/infinityworks/iw-data-test-python.git    

After a successful clone and packages have been installed, generate the data using:

    python ./input_data_generator/main_data_generator.py

Next select the database and schemas we wish to load the data into.

    USE DATABASE RAW_DATA;
    USE SCHEMA SALES;

Load the data into the named stage with the `PUT` command:

    put file://path/to/file/*.json @%TRANSACTIONS SOURCE_COMPRESSION = AUTO_DETECT;

If this returns a successful result, we can copy the data from the stage into the the table.

     copy into "RAW_DATA"."SALES"."TRANSACTIONS" from @%TRANSACTIONS/transactions.json.gz file_format = (TYPE='JSON') on_error = 'skip_file';
