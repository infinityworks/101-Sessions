# 101 Terraform

The repos is designed to be used alongside the Infinity Works 100 Training for Terraform
[Meetup.com](https://www.meetup.com/Infinity-Works-101-Sessions/events/255765040/)

## Pre-requisits

### An AWS account & CLI

As we will be using Terraform in conjunction with AWS you will also need to to create an **AWS account** and install the Command Line Interface tool (**CLI**). Instructions are below:

* https://aws.amazon.com/free/free-tier/
* https://aws.amazon.com/cli/

We will be using the **eu-west-2** region if asked in the above process.

### Managing AWS credentails locally

Your AWS account if new will most likely be locked down just to yourself to access you should have a programatical access set of credentails (Go create some in AWS IAM)
These can be added to your environment by following this guide: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html 

If you have these you wont need at add additional environment variables, howere if you donnt't have these setup you can mannually set the env for the session with:

```bash
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="eu-west-1"
```

### An IDE 

It would also be a good idea to have an (Integrated Development Environment) IDE installed, **VS Code** is a free feature rich IDE and can be downloaded/installed from: https://code.visualstudio.com/

We can help in the session with the above, but doing before will save you time.

## Usage

Initalise the Teraform providers etc
```bash
terraform init
```

Plan what will be changed
```bash
terraform plan
```

Apply the changes to the infrastructure
```bash
terraform apply
```

Destroy the infrastructure
```bash
terraform destroy
```