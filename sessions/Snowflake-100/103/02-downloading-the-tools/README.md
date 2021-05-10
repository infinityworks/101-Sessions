# Downloading the programmatic deployment tools

## SnowSQL CLI

For the next sections you'll need [Snowflake's CLI](https://docs.snowflake.com/en/user-guide/snowsql-install-config.html#installing-snowsql), snowsql; download it from their website or use a package manager.

If you're a Mac user and use Homebrew:

    brew cask install snowflake-snowsql

To confirm and create any config files, run:

    snowsql

This will also create a config file in `~/.snowsql/config` used for authentication and setting default values such as `role` and `warehouse`.

Edit the file and create a Snowflake profile (connections is the default profile), e.g:

    [connections]
    accountname = myAccout
    region = eu-west-1
    username = YourUserName
    password = YourPass

If you are using multiple Snowflake accounts or users, you can create additional profiles in this file using the same structure:

    [connections.demo]
    accountname = infinityworkspartner
    region = eu-west-1
    username = YourUserName
    password = YourPassword

Now you've configured your CLI profiles, enter the CLI in the terminal using your default profile with:

    snowsql

or to select another profile, for example with the name `connections.demo`:

    snowsql -c demo

You should now have access to Snowflake via the CLI:

![Snowsql CLI](./assets/snowsql_cli.png "Snowflake console")

## Terraform 0.13

The current version of Snow Cannon uses Terraform v0.13 and automatically downloads the Snowflake Terraform provider from the Terraform registry when calling the `required_providers` block. If your project requires Terraform v0.12 it is still possible, though a manual provider installation is required and the `required_providers` block will need to be removed.

Download Terraform v0.13 from [their website](https://www.terraform.io/downloads.html) or use a package manager.

If you already have an older version of Terraform, a useful versioning package called `tfswitch` allows you to have multiple versions of Terraform on your machine which you can change between - all Terraform commands remain the same.

Switch between versions with:

    tfswitch 0.12.29
    tfswitch 0.13.2

Find the [installation instructions here](https://github.com/warrensbox/terraform-switcher).

## AWS CLI

You will also need the [AWS CLI](https://aws.amazon.com/cli/) installed to push data into S3.


## Python 3

[Python](https://www.python.org/downloads/release/python-381/) is required as some scripts have been included in the modules where, currently, the Terraform provider lacks the functionality.

## Pre-commit

Pre-commit is only required if you wish to contribute to the project.
