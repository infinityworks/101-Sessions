# The repo

You will need to clone the [Snow Cannon](https://github.com/infinityworks/snow-cannon/) repo in order to start Terraforming.

    git clone git@github.com:infinityworks/snow-cannon.git

The directory structure is split into AWS and Snowflake resources. Within AWS you will find templated code for creating an s3 bucket, Terraform state resources and a module for creating IAM roles; this module will be called by "Snowflake modules" when a resource requires an IAM role.

The Snowflake directory is split by infrastructure and role based access control. All Snowflake modules, including creating integrations, stages and pipes, can be found in `snowflake/infra/modules` - these are later called from an appropriate directory where you want to create resources, such as `snowflake/infra/stages`.

To begin we need to authenticate both SnowSQL and Terraform.

## Setting your ENV VARS

To deploy Snowflake using Terraform, this project depends on user authentication by environment variables; to simplify this process we load the SnowSQL config credentials file using a python script; the two Terraform env vars outputted are `SNOWFLAKE_USER` and `SNOWFLAKE_PASSWORD`.

The python script accepts two optional arguments, `profile` and `application`; these determine the Snowflake profile you wish to use in your SnowSQL config and the env vars to export. If the flags are not called, they will default to using your `connections` profile and output both terraform and SnowSQL env vars. **The CLI arguments are case sensitive**. The accepted values for `application` are `terraform`, `snowsql` or `all`, for example:

If you have not yet [created create your snowsql profile](../../102/01-installing-snowsql/README.md), it must be done now.

     eval $(python3 load_snowflake_credentials.py --profile connections.iw --application all)

NOTE: This must be run in an `eval $( )` statement as the python script prints your vars to the terminal and `eval` evaluates the export statement, loading them into your environment. **If you do not use the `eval` statement your creds will be printed in plain text to your terminal and not loaded into your environment variables**.

Remember to execute this `eval` statement for each terminal window you are working in.

## Name your project

Many resources in the template code derive their names from your project name; for a simple find and replace - run the following in the Snow Cannon project:

    python3 project_setup.py
