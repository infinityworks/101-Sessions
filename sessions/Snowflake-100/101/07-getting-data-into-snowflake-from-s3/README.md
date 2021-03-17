# Getting data into Snowflake from AWS S3

A snowflake account can be connected to an external cloud account to consume data from or send data to.

Similar to importing and exporting data from a local machine, we require a stage. This stage will need two supporting resources, a `storage integration` with the account details and an authentication resource - in the case of AWS, an `IAM role`.


Once the policy and role has been created, we require a snowflake resource called `storage integration`.

## Storage Integrations [[docs](https://docs.snowflake.com/en/sql-reference/sql/create-storage-integration.html)]

A storage integration forms the bridge between Snowflake and your AWS account, and contains the authentication required to access resources like s3. The integration must be created by the ACCOUNTADMIN and any resources that depend on it must also be created by the ACCOUNTADMIN role.

    USE ROLE ACCOUNTADMIN;
    CREATE OR REPLACE STORAGE INTEGRATION S3_STORAGE_INTEGRATION
      TYPE = external_stage
      STORAGE_PROVIDER = s3
      ENABLED = true
      STORAGE_ALLOWED_LOCATIONS = ('s3://generation-snowflake-day');


Next we need to retrieve the Snowflake account information from the integration and update the IAM. Do this using:

```DESC INTEGRATION S3_STORAGE_INTEGRATION```

![Storage Integration](./assets/storage-integration.png "Storage Integration")

make a note of the `STORAGE_AWS_IAM_USER_ARN` and `STORAGE_AWS_EXTERNAL_ID`, these are specific to your Snowflake account and their values are to be included in the IAM role.


## External stage [[docs](https://docs.snowflake.com/en/user-guide/data-load-s3-create-stage.html#external-stages)]

An external stage is used to "look" into the bucket, this relies on the account storage integration that we have just created. The stage must be created within a database and schema. A stage can be a bucket but also just a subfolder of a bucket.

```
USE ROLE ACCOUNTADMIN;

USE DATABASE RAW_DATA;

USE SCHEMA SALES;

CREATE OR REPLACE S3_EXTERNAL_STAGE
    URL = 's3://generation-snowflake-day/'
    STORAGE_INTEGRATION = S3_STORAGE_INTEGRATION;
```

# List the contents of the stage

Once the data is in s3, check the stage can see it with:

```LIST @S3_EXTERNAL_STAGE;```

```
COPY INTO 
    RAW_DATA.SALES.TRANSACTIONS
FROM
    @S3_EXTERNAL_STAGE/transactions.json
    FILE_FORMAT = (TYPE = 'JSON')
    ON_ERROR = 'skip_file';
```

You can now query the data ingested from S3 using:

```SELECT * FROM RAW_DATA.SALES.TRANSACTIONS```
