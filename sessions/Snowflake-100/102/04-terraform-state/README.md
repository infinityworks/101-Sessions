# Terraform Remote state and lock table

To begin we must create a remote state bucket and lock table within an AWS account; this is referenced to keep track of all changes made by Terraform and ensures stateful deployments.

The remote state bucket and lock table's name are comprised of your project name, this can be updated in `./aws/state_resources/s3/environment/dev/environment.tfvars`. Your AWS region can be updated in `./aws/state_resources/s3/variables.tf`

**If you are using the IW AWS sandbox account, you must update the above file before planning and applying to ensure your resources are uniquely named; one suggestion is to include a hash or your initials in the project name**

To run terraform locally you must have a [valid aws session](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and [set your `AWS_PROFILE`](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html).

In order to deploy the state bucket, navigate to `./aws/state_resources/s3/` and run:

    terraform init
    terraform plan -var-file=environment/dev/environment.tfvars -out=tfplan
    terraform apply tfplan
    rm -r .terraform && rm tfplan

This will create a remote state bucket with the name `<your-project>-remote-state-<env>`. Next for the lock table, again changing the `environment.tfvars` variables and region, `./aws/state_resources/s3/variables.tf`:

    cd ../dynamoDB
    terraform init -backend=true -backend-config=environment/dev/backend-config.tfvars
    terraform plan -var-file=environment/dev/environment.tfvars -out=tfplan
    terraform apply tfplan
    rm -r .terraform && rm tfplan

Check with the aws CLI that `<your-project>-lock-table` now exists:

    aws dynamodb list-tables

Now we have our state infrastructure we can begin Terraforming Snowflake and its AWS counterparts.
