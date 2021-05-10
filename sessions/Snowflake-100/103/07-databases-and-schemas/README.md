## Databases [[docs](https://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/database.md)] and schemas [[docs](hhttps://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/schema.md)]
The pattern of declaring a resource, referencing the remote state for any dependencies and granting permissions to it is used in other resource creation, such as databases. To use a database, at a minimum a role must have `usage` grants. [[docs](https://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/database_grant.md)]

It is recommended that databases have their own dedicated `.tf` file which includes its grant statements.

Schemas should be separated by directory for each database created:

    ├── schemas
        ├── analytics_db
        │   ├── marketing
        │   ├── sales
        │   └── customer
        └── models_db
            ├── schema1
            ├── schema2
            └── schema3

Roles will also need to be granted access to schemas with the [grant block](https://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/schema_grant.md).

Navigate to `snowflake/infra/databases/`, update any naming you wish and run the terraform.

    terraform init
    terraform workspace new dev || terraform workspace select dev
    terraform plan
    terraform apply

Following this we can build schemas in `snowflake/infra/schemas/`
