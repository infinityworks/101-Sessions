## Users [[provider docs](https://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/user.md)]
To create users, navigate to `./snowflake/rbac/users/` and create a new `.tf` file for each group of users, a recommended approach is to create one file per squad or business area.  Within this file use the provider resource `snowflake_user` and define the user's preferences:

    resource "snowflake_user" "user_DanielLaRusso" {
      name                 = "DanielLaRusso"
      login_name           = "DanielLaRusso"
      default_role         = "PUBLIC"
      password             = "replace"
      must_change_password = "true"
      comment              = "Data consumer in the transport squad"
    }

For now, leave the default role as `PUBLIC`, since the user block will not automatically grant said role.

To grant the user a role we will reference the user's name from the above resource using Terraform outputs; create an output in `outputs.tf` with the following structure:

    output "DanielLaRusso_name" {
      value = snowflake_user.user_DanielLaRusso.name
    }

The default password is currently "replace", this must be changed immediately after creation, by the user in the Snowflake console.

**Note:** Any plain text run through Terraform will be stored in the remote state and so a user's chosen password should not be included in Terraform and a generic one is provided; it is recommended to include the flag to force a user to change their password on first login. Feel free to change the sample password in the Terraform code to make things less generic (in a live system it is possible people may try and log in as new users if they know the generic password after user creation).


The `main.tf` file configures Terraform - including the snowflake region, account and role. These are to be updated in `./snowflake/rbac/users/variables.tf`. You can also see the required provider block which will download and install the provider on initialisation.

    terraform {
      required_version = ">= 0.13.2"
      backend "s3" {}
      required_providers {
        snowflake = {
          source  = "chanzuckerberg/snowflake"
          version = "0.15.0"
        }
      }
    }

    provider "snowflake" {
      account = var.snowflake_account
      region  = var.snowflake_region
      role    = "SECURITYADMIN"
    }


Once the variables have been updated, run:

    terraform init -backend=true -backend-config=environment/dev/backend-config.tfvars
    terraform plan -var-file=environment/dev/environment.tfvars -out=tfplan
    terraform apply tfplan
    rm -r .terraform && rm tfplan

This pattern of initialisation, planning and deployment is repeated across each directory to create different resources.

# Roles ([provider docs](https://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/role.md))
Roles are created in a similar way to users in `./Snowflake/rbac/roles/`. Each role comes with a grant block which will grant the role created to users or other roles. It is recommended that one role is created per file to maintain separation and ease of organisation.

To persist user changes, for example name or default roles, it is recommended to reference the user's `name` value from the remote state of the user file. This is achieved by the `data` block, `terraform_remote_state` in a `data.tf` file.

**WARNING:** As previously mentioned, grant statements will misbehave if instantiated multiple times to the same object. The provider appears to run a query to find where the grant statement has already been applied and finds the difference to the grant block you are running; this includes removing any granted permissions that were created in the console and not through code using this provider and remote state. It is recommended not to use the resource which grants AccountAdmin, when revoking or destroying it is possible to remove your own role access and lock yourself out.

The role and permission block ([provider docs](https://github.com/chanzuckerberg/terraform-provider-snowflake/blob/master/docs/resources/role_grants.md))looks like the following. It is here we can assign the role to a user or other roles.

    resource "snowflake_role" "DATA_ANALYST" {
      name    = "DATA_ANALYST"
      comment = "A role used to access the analytics layer"
    }

    resource "snowflake_role_grants" "grants_on_role_DATA_ANALYST" {
      role_name = snowflake_role.DATA_ANALYST.name

      users = [
        data.terraform_remote_state.user_info.outputs.user_ANALYST_name,
      ]
    }

**Note:** If you are referencing the remote state, be sure to update the bucket and file key in `data.tf`.

After any edits in `./Snowflake/rbac/roles/`, run:

    terraform init -backend=true -backend-config=environment/dev/backend-config.tfvars
    terraform plan -var-file=environment/dev/environment.tfvars -out=tfplan
    terraform apply tfplan
    rm -r .terraform && rm tfplan
