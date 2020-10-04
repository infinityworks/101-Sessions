# Snowpipe Module

The Snowpipe module is a revolutionary approach to setting up automated data ingestion with Snowflake. During the 101 we saw it took a long time to configure the table, IAM role, storage integration, IAM update, stage, pipe and bucket notification and if an integration is updated, as the external ID changes we have to tear down any resources that rely on it; the Terraform module can handle all the above and in it's simplest form deploy all the resources from two lines of code, the bucket name and key.

    module "test_pipe" {
      source         = "../../modules/snowpipe-module/"
      s3_bucket_name = "snow-cannon-data-lake-${lower(var.env)}"
      s3_path        = "key3"
    }

The database, schema and other common variables have been set as defaults within the module, these can be changed within or included in the module block above.

**Note:** to benefit from the decoupled nature of the pipes resources through using modules, we also create them in their own directory with their own remote state, that ensures they truly are decoupled.

Navigate to `./snowflake/infra/pipes/test-pipe/main.tf` where you can see an example in action. Init, plan and apply to deploy this; it should take approximately 30 seconds!

## Ingesting structured data

The default file format to be consumed is JSON; this can be changed to ingest tabular objects such as CSV files using the following variables:
- file_format
- record_delimiter
- field_delimiter

The following example shows how to customise your pipe requirements, including the file suffix; the suffix can include characters of the filename but is mainly used to declare the filetype to be consumed.

    module "finance_snowpipe" {
        source           = "../../modules/snowpipe-module/"
        s3_bucket_name   = "marketing-analytics"
        s3_key           = "finance"
        has_key          = false
        file_format      = "CSV"
        field_delimiter  = "\t"
        record_delimiter = "\n"
        filter_suffix    = ".csv"
    }

For the case of structured data, such as a `.csv` or `.tsv.gz`, you must provide a table definition of the columns and datatype. The structure is:

    field,type
    col1,INTEGER
    col2,VARCHAR
    col3,FLOAT

and is located in the working directory where the pipe is to be created within the file `table-definition.csv`. Terraform will read this and generate the DDL statement for the landing table. In the case of semi-structures data, like JSON, a single column will be created with the Snowflake `variant` datatype.

All landing tables have a timestamp column to note when the record was ingested by Snowflake.

# Ingest all the sample data

Can you put together three modular pipes to ingest all the data generated from running the python script in the 101?

The three sources are:

- Transactions
- Customer data
- Product data

We have the template code needed for JSON data, all we need to do is customise it to ingest the transactions data. A suggestion is to define the keys in the s3 bucket by each data source.

You will require a further two pipes for ingesting `.csv` files. With the instructions above we need to create additional directories to separate the pipes and remote state and provide a definition csv for the column names and data types.

**Note:** the `backend-config.tfvars` files keys will need to be updated to prevent a state file being overwritten by a different resource.

Once you have created and deployed the pipes for these three source, push all of the data via the AWS CLI to s3 to the respective keys you listed in the pipe module configurations.

Check each pipe's status to see how much data has successfully registered a notification and queued:

    SELECT system$pipe_status('database_name.schema_name.pipe_name');

Once all the data has landed, query the data and see what insights you can draw from it.
