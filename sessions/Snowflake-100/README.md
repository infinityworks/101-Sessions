# Snowflake 101 - Terraforming a Snowflake data warehouse

## Sessions

### Snow Cannon-100

- Overview and Trainer Introduction
- [What is Snowflake](https://github.com/infinityworks/knowledge-base/blob/master/items/snowflake.md)
- Why is it useful?
- Noteworthy features of Snowflake
- Snowflake tech partners

### Snow Cannon-101

- Setting up a Snowflake account
- Creating resources:
    - Users
    - Roles
    - Databases
    - Schemas
    - Tables
        - Useful data types
- Getting data into Snowflake
- Querying
- Getting data out of Snowflake
- Automating data ingestion from s3
    - Account integrations: connecting Snowflake to AWS s3
    - IAM Roles
        - What is an IAM role
        - Configuring the role
    - Stages: Where the source data lives
    - Landing data with Snowpipes
        - Pushing data from the CLI

### Snow Cannon-102
- Recap of 101
- Programmatic deployments
    - How the UK's largest account does it
    - Previous attempts and learnings
    - The power of CI/CD and infrastructure as code
    - What is Terraform and how does it work?
- Downloading the tools
    - Snowsql CLI
    - Terraform 0.13
- Deploying Snowflake resources through Terraform
    - Introduction to Snow Cannon
    - Setting up the codebase
    - Users and roles
    - Databases and schemas
    - Modules - Have the heavy lifting done for you
        - Integrations
        - Stages
        - Pipes
- Zero to warehouse in 60 seconds
- Automating data exports to s3

### Snow Cannon-103
- Recap of 102
- End-to-end pipe creation for .csv files
- Warehousing streaming data with AWS Kinesis Firehose
- Consuming event data from lambda -> EventBridge -> Firehose
- DynamoDB Streams
- How we're combining Snow Cannon with SFTP
- Overview of programmatic interfaces and dashboarding
- Recap of the Course.
