## Databases and schemas
The above pattern of declaring a resource, referencing the remote state for any dependencies and granting permissions to it is used in other resource creation, such as databases. At a minimum a role must have `usage` granted to access a database.

It is recommended that databases have their own dedicated `.tf` file which includes it's grant statements. Schemas should be separated by directory for each database created:

    ├── schemas
        ├── analytics_db
        │   ├── marketing
        │   ├── sales
        │   └── customer
        └── models_db
            ├── schema1
            ├── schema2
            └── schema3
