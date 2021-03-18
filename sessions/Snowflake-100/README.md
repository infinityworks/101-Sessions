# Snowflake 101 - Creating a data warehouse

This 101 session can be guided or completed solo.

The learning aims are to build a Snowflake data warehouse from scratch which can ingest data from the local filesystem and AWS S3, and unload / export data as `.csv`.

The 102 covers how to deploy Snowflake through code using Terraform.

[See here for the Instructors guide](https://github.com/infinityworks/101-Sessions/blob/master/sessions/Snowflake-100/INSTRUCTORS_GUIDE.md)

## Sessions

### 100 Introduction

- Overview and Trainer Introduction
- [What is Snowflake](https://kb.infinityworks.com/snowflake/)
- Why is it useful?
- Noteworthy features of Snowflake
- Snowflake tech partners

### 101 Warehousing & Getting Data In / Out

- Setting up a Snowflake account
- Snowflake UI Tour
- Creating resources:
    - Users
    - Roles
    - Databases
    - Schemas
    - Tables
        - Data types
- Getting data in
- Querying
- Getting data out
- Ingesting data from a cloud provider
    - Storage Integrations: connecting Snowflake to S3
    - Stages: Where the source data lives

### 102 Deploying Snowflake With Terraform
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

### 103 Snowflake In An Event Driven Architecture
- Recap of 102
- End-to-end pipe creation for .csv files
- Warehousing streaming data with AWS Kinesis Firehose
- Consuming event data from lambda -> EventBridge -> Firehose
- DynamoDB Streams
- How we're combining Snow Cannon with SFTP
- Overview of programmatic interfaces and dashboarding
- Recap of the Course.
