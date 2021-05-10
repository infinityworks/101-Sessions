# Snowflake 101 - Creating a data warehouse

This 101 session can be guided or completed solo.

The learning aims are to build a Snowflake data warehouse from scratch which can ingest data from the local filesystem and AWS S3, and unload / export data as `.csv`.

The 102 covers how to connect Snowflake to AWS S3 for automated data ingestion.

The 103 covers how to deploy Snowflake through code using Terraform.

[See here for the Instructors guide](https://github.com/infinityworks/101-Sessions/blob/master/sessions/Snowflake-100/INSTRUCTORS_GUIDE.md)

## Sessions

### 100 Introduction

- Overview and Trainer Introduction
- [What is Snowflake](https://kb.infinityworks.com/snowflake/)
- Why is it useful?
- Noteworthy features of Snowflake

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

### 102 Connecting to the cloud
- Connecting Snowflake to AWS S3
    - IAM access roles
    - Integrations
    - External Stages
    - Copy from Stage to Snowflake table
- Automating data ingestion with Snowpipes
    - Pipes
    - Queues
    - S3 bucket notifications

### 103 Terraforming Snowflake

- Introduction to Snow Cannon
- Downloading the tools
    - Snowsql CLI
    - Terraform 0.13
- Deploying Snowflake resources through Terraform
    - Setting up the codebase
    - Users and roles
    - Databases and schemas
    - Modules - Have the heavy lifting done for you
        - Integrations
        - Stages
        - Pipes
- Automating data imports from s3        
- Automating data exports to s3
- Zero to warehouse in 60 seconds
