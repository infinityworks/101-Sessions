# Terraform Remote state and lock table

To begin we must create a remote state bucket and lock table within an AWS account; this is referenced to keep track of all changes made by Terraform and ensures stateful deployments.

The remote state bucket and lock table's name are comprised of your `project name` which was set in the previous chapter.

To run terraform locally you must have a [valid aws session](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and [set your `AWS_PROFILE`](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html).

In order to deploy the state bucket, navigate to `./aws/state_resources/s3/` and run:

    terraform init
    terraform workspace new dev || terraform workspace select dev
    terraform apply
    rm -r .terraform

This will create a remote state bucket with the name `<your-project>-remote-state`. Next for the lock table, in `./aws/state_resources/dynamoDB/`:

    cd ../dynamoDB
    terraform init
    terraform workspace new dev || terraform workspace select dev
    terraform apply
    rm -r .terraform

Check with the aws CLI that `<your-project>-lock-table` now exists:

    aws dynamodb list-tables

Now we have our state infrastructure we can begin Terraforming Snowflake and its AWS counterparts.
