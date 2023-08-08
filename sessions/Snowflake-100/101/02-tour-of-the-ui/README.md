# A quick tour of the UI


## The main menu

The menu on the left allows you to switch between the different areas of Snowflake.

![Snowflake main menu](./assets/snowflake_menu.png "Snowflake main menu")

Areas:
* Worksheets
* Dashboards
* Apps
* Data
* Marketplace
* Activity
* Admin
* Help & Support

## Worksheets

Provides an interface for submitting SQL queries, performing DDL and DML operations and viewing results as your queries/operations complete.

Each worksheet has it's own "context" which defines which role, warehouse, database, and schema your queries will be run inside. This allows you to have multiple worksheets simultaneously with different config. This differs from the account context (top left) which determines which items appear in the menu and what function you are allowed to run in the UI outside of the worksheet context.

![Snowflake worksheets](./assets/snowflake_worksheet.png "Snowflake worksheets")

Worksheets are saved automatically each time you change the content and will be persisted in your account until you explicily remove them.

## Dashboards
Visualise your data with basic charts and graphs from mulitple queries in a dashboard.

## Apps
Install third party apps to add extra functionality to your Snowflake account. At the time of writing this is a preview feature, available only on AWS-backed Snowflake accounts.

## Data

Shows information about the databases you have created or have privileges to access. You can create, clone, drop, or transfer ownership of databases as well as load data (limited) in the UI.

![Snowflake databases](./assets/snowflake_databases.png "Snowflake databases")

## Marketplace

Allows you to import pre-made data sets curated by external companies.

## Activity

Allows you to view the details of all queries executed in the last 14 days in the Snowflake account.

## Shares

Allows data sharing to be configured to easily and securely share Snowflake table(s) among separate Snowflake accounts or external users.

## Admin
The Admin area allows you to manage/monitor billing and resource usage as well as create users and roles. 

This is also where you set up and manage compute resources (virtual warehouses) to load or query data in Snowflake.

![Snowflake warehouses](./assets/snowflake_warehouses.png "Snowflake warehouses")


What you see in the Admin section will depend on which system roles you have been assigned. If you have `ACCOUNTADMIN` then you'll see everything, otherwise you'll only see things relevant to the role you have selected.