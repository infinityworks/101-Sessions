# Modules

Terraform modules allow us to template and configure resources to simplify and standardise our resource deployments.

This repo makes use of nesting modules so we can re-use the module code when another depends on it, for example: when using the stage module, this call the integration module which in-turn calls the IAM module, creating all three resources from only four input parameters.

Each resource name is dynamically created based on the location or key you provide it in your cloud storage.

    module "stage_example" {
      source         = "../modules/stages-module/"
      s3_bucket_name = "my-data-lake-${lower(var.env)}"
      s3_path        = "key2"
      database       = "ANALYTICS"
      schema         = "PUBLIC"
    }

Here we use the bucket `my-data-lake-${lower(var.env)}` where the environment variable determines the environment we're deploying to, e.g. dev, staging or prod. The s3_path is the key your files are located in, if the files are in the top level of the bucket you must set the variable `has_key=false`, by default this is set to true. Take a look in `snowflake/infra/modules/stages-module/stages-base/main.tf` to see where this logic is being applied to the `locals` variable `s3_bucket_and_key`.

Each module has a base layer for the main resource you are creating, this templates the code and sets default values in `variables.tf`. The base layer is then imported to the `main.tf` of the module directory which again, should be a series of simplified, often default, arguments where we reuse the outputs for layers higher up the chain. The result being when we want to run a module they have minimal input parameters and maintaining the modules should maintain all the code around our system.

Navigate to `snowflake/infra/storage_integrations/main.tf` and edit the modules' input parameters to create your own, along with an init, plan and apply. Check it exists, in the console with:

    SHOW INTEGRATIONS;

Next try this with stages.
