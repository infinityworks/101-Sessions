# Terraforming Snowflake

The [Chan Zuckerberg Initiative created an open source Terraform provider](https://github.com/chanzuckerberg/terraform-provider-snowflake) which out-of-the-box can create, modify and destroy many Snowflake resources across infra and rbac all through code.

Infrastructure as code increases reliability of deployments, versions them if a rollback is needed, can undergo a peer review process before deployment and by its nature is its own documentation.


## [Snow cannon](https://github.com/infinityworks/snow-cannon/)

Snow cannon is a project born out of the necessity to solve the following issues:

- Executing sql in the console doesn't provide change control or a peer review process across RBAC and infra.
- Updating resources across multiple environments and avoiding configuration drift is difficult.
- Deployment scripts require more maintenance with `Create`, `Alter` or `Drop` statements.
- Little to no documentation through code relies on engineers maintaining up-to-date documentation on the system.
- Systems can be cumbersome and couple resources resulting in a tangled web of dependencies.

Snow cannon is an abstraction layer that sits on top of the provider and uses Terraform modules to create infrastructure such as Snowpipes and all their supporting resources; in the case of a pipe the module will create the pipe, bucket notification, external stage, account integration, IAM role and landing table. 

Now we understand how to get data in and out of Snowflake, we will apply versioned, good software practices to our deployments, which will also simplify and speed up the deployment process.
