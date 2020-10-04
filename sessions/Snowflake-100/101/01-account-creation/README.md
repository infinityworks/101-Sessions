# Creating a Snowflake account

Open a browser and navigate to the [Snowflake homepage](https://www.snowflake.com/) and select `Start For Free`.

![Snowflake homepage](./assets/snowflake_homepage.png "Snowflake homepage")

You'll need to enter the following details to set up a Snowflake account.

- Name, Email address, Title, Company, Country

Account type:
- Tiering / edition: Recommend Enterprise for multi-cluster compute and other features
- Cloud platform to host on (this isn't your cloud account but under-the-hood where your Snowflake account will be hosted): Recommended AWS
- Region: This parameter is independent of the region your external cloud account uses. Recommended Ireland (eu-west-1)
- Telephone number: (020) 7946 0000

Confirm your email address and begin your account.

![Activate account](./assets/activate_user.png "Activate account")

The user details you enter will be the default account admin, name this appropriately and after initial account set up and RBAC implementation, lock this user away for emergencies or infrequent access.

You should enter the console and see the following:

![Snowflake console](./assets/snowflake_console.png "Snowflake console")

## Console functionality
For a quick tour of the console check the [docs](https://docs.snowflake.com/en/user-guide/ui-worksheet.html)!
