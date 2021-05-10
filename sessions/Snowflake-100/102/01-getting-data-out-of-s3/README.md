# Getting data out of a secured S3 bucket

We have seen it's possible to consume data from cloud accounts, now we'd like to do it from a secured S3 bucket.

We require a `stage` which points to the bucket and is authenticated through an `account integration` and `IAM role`.

This exercise relies on having already created an S3 bucket; if you do not have one in your account - please create one now.

## IAM (Identity and Access Management) [[docs](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)]

> AWS Identity and Access Management (IAM) is a web service that helps you securely control access to AWS resources. You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.
>
> An IAM role is an IAM identity that you can create in your account that has specific permissions. An IAM role is similar to an IAM user, in that it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS.

### Creating an IAM role [[docs](https://docs.snowflake.com/en/user-guide/data-load-s3-config.html)]

To read from S3 we require an IAM role which can `get` an object and its version, and list the buckets. Follow Option 1, Steps 1 & 2 of [Snowflake's instructions here](https://docs.snowflake.com/en/user-guide/data-load-s3-config.html). During IAM creation we will need information from our Snowflake account which doesn't exist yet, a circular dependency, this will be updated after the storage integration has been created.

Your IAM role will require a policy which at a minimum must have `get` permissions; this will look like:

    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:GetObject",
              "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::<bucket>/<prefix>/*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::<bucket>",
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "<prefix>/*"
                    ]
                }
            }
        }
    ]
    }


Once the policy and role has been created, we require a snowflake `storage integration`.

## Storage Integrations [[docs](https://docs.snowflake.com/en/sql-reference/sql/create-storage-integration.html)]

A storage integration forms the bridge between Snowflake and your AWS account, and contains the authentication required to access resources like s3. The integration must be created by the ACCOUNTADMIN and any resources that depend on it must also be created by the ACCOUNTADMIN role.

    USE ROLE ACCOUNTADMIN;
    create or replace storage integration S3_STORAGE_INTEGRATION
      type = external_stage
      storage_provider = s3
      storage_aws_role_arn = "arn:aws:iam::<aws-account-id>:role/<your-role-name>"
      enabled = true
      storage_allowed_locations = ('s3://<bucket-name>');


Next we need to retrieve the Snowflake account information from the integration and update the IAM role to allow adoption by a user provisioned by Snowflake. Do this using:

      desc integration S3_STORAGE_INTEGRATION

![Storage Integration](./assets/storage-integration.png "Storage Integration")

make a note of the `STORAGE_AWS_IAM_USER_ARN` and `STORAGE_AWS_EXTERNAL_ID`, these are specific to your Snowflake account and their values are to be included in your IAM role.

Return to the [Snowflake docs and follow Step 5](https://docs.snowflake.com/en/user-guide/data-load-s3-config.html#step-5-grant-the-iam-user-permissions-to-access-bucket-objects) to update the policy document and modify the trust relationship.

    {
    "Version": "2012-10-17",
    "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "AWS": [
                  "<STORAGE_AWS_IAM_USER_ARN>"
              ]
          },
          "Action": "sts:AssumeRole",
          "Condition": {
              "StringEquals": {
                  "sts:ExternalId":"<STORAGE_AWS_EXTERNAL_ID>"
              }
          }
      }
    ]
    }

**NOTE:** If the storage integration is modified, a new external ID will be generated and the IAM role will require this update.

## External stage [[docs](https://docs.snowflake.com/en/user-guide/data-load-s3-create-stage.html#external-stages)]

An external stage is used to "look" into the bucket, this relies on the account storage integration that we have just created. The stage must be created within a database and schema.

    USE ROLE ACCOUNTADMIN;
    USE DATABASE RAW_DATA;
    USE SCHEMA SALES;
    create or replace stage S3_EXTERNAL_STAGE
        url='s3://<bucket-name>/'
        storage_integration = S3_STORAGE_INTEGRATION;

## Push local data to s3 with the AWS CLI

From loading data earlier you should have the file `all_transactions.json`. If you no longer have access to this, download it using:

    curl https://snowflake-101.s3.eu-west-2.amazonaws.com/all_transactions.json >> all_transactions.json

To push the data to S3, run:

    aws s3 cp /path/to/file/all_transactions.json s3://<bucket-name>/all_transactions.json

Once the data is in s3, check the stage can see it with:

      list @S3_EXTERNAL_STAGE;

Again, clear the data that exists in the table before we copy it from S3:

    TRUNCATE TABLE RAW_DATA.SALES.TRANSACTIONS;

Then copy the data to your table:

    COPY INTO "RAW_DATA"."SALES"."TRANSACTIONS"
        FROM @S3_EXTERNAL_STAGE/all_transactions.json
        FILE_FORMAT = (TYPE= 'JSON')
        ON_ERROR = 'skip_file';

You can now query the data ingested from s3 using:

    SELECT * FROM "RAW_DATA"."SALES".TRANSACTIONS
