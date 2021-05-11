# Snowflake 101 - Creating a data warehouse

This 101 session can be guided or completed solo.

The learning aims are to build a Snowflake data warehouse from scratch which can ingest data from the local filesystem and AWS S3, and unload / export data as `.csv`.

The 102 covers how to connect Snowflake to AWS S3 for automated data ingestion.

The 103 covers how to deploy Snowflake through code using Terraform.

## [Why Snowflake?](https://kb.infinityworks.com/snowflake/)
Check out the knowledge base article on why we use it.

## Who should take this workshop?

Anyone interested in building a data warehouse with Snowflake, those wishing to integrate with AWS to extend their data platform and those who want to learn how to build a data platform using infrastructure as code with Terraform.

## Pre-requisites

### Experience
- Snowflake experience not required.
- AWS experience with S3, IAM roles and policies desirable but not essential; DynamoDB is a bonus.
- Working knowledge of Terraform is strongly preferred for the 102 but not essential.
- Working knowledge of Docker is preferred but not essential.

### Accounts
- Snowflake accounts
- AWS account (for the 102 onwards)

### Tools
- Snowflake account with ACCOUNTADMIN role (create a free trial account and choose the enterprise edition).
- 102 Onwards - AWS with unrestricted access / deployment privileges that you can use in a local session with the AWS CLI.

- OS:
    - Ubuntu, Mac OS (UNIX based etc) strongly preferred
    - Windows not recommended

Installations:
- Minimum (not recommended but acceptable):
    - VS Code + Extension Code Remote – Containers
    - Docker v20.10
- Preferred:
    - AWS Command Line Interface v2.0 (test connectivity to your AWS account via CLI)
    - Docker v20.10
    - Python >= 3.6
        - botocore>=1.17
        - boto3>=1.12
    - Terraform v13
    - SnowSQL CLI v1.2 (test connectivity to your Snowflake account via CLI)


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
- Analytics dashboards with Metabase

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
