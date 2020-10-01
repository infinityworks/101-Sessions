# Provisioning Snowflake resources
Some resources are dependent on others already existing, for example schemas belong to databases, and stages belong to a schema within a database; thus we must deploy resources in a specific order:

1. RBAC
1. Warehouses
1. Integrations
1. Databases
1. Schemas
1. Stage
1. Pipes
1. Tasks

Each directory containing a resource has an associated `main.tf` file which declares the provider; this provider includes the Snowflake account name, region and role which is adopted to create, modify and destroy infra. You must ensure you can adopt the appropriate roles required by Snowflake. With an infra as code approach, this project is designed to be deployed across multiple environments using separate accounts; the separation is controlled through configuration with `environment.tfvars` files (though it is possible to deploy `n` environments in a single account by appending resource names with the env).

## Modules
Modules are a key element of what makes this project successful, particularly for automating data ingestion from cloud storage. Modules simplify the work flow and reduce maintenance of groups of resources that depend on each other. For example, the pipes-module will dynamically create the supporting infrastructure of an landing table, account integration, AWS iam role, external stage and the pipe itself, as a one-to-one relationship. Each data flow is decoupled and independent from one another.

Beware, when creating modules they can cause deployment and destruction conflicts; for example, independently **granting permissions** on roles to a resource will conflict with other module deployments as the Terraform provider looks for global permissions and finds the difference; having multiple grant objects will conflict with each other as the sql output is no longer a single source of truth when comparing one Terraform block to another. To avoid this, all resource grant statements much be in a single block.
