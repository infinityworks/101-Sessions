# Downloading the programmatic deployment tools

## SnowSQL

If you haven't already, [download Snowflake's CLI](https://docs.snowflake.com/en/user-guide/snowsql-install-config.html#installing-snowsql), snowsql.

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
