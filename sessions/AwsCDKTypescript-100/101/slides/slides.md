# AWS CDK Typescript

Steven Harper & Adrian Hesketh

https://infinityworks.com

---

# What is Infrastructure as Code (IAC)

* <mdi-check-circle class="text-green-400" /> Express environments & resources in “code”
* <mdi-check-circle class="text-green-400" /> Repeatable outcomes, when creating resources
* <mdi-check-circle class="text-green-400" /> Reduce human error when making changes
* <mdi-check-circle class="text-green-400" /> Allows versioning, and rollback

---
layout: two-cols-header
---

# What came before CDK

::left::

![Local Image](aws-cloud.png)

::right::

* AWS Console
* APIs
* AWS CLI
* Cloud Formation
* Serverless Framework
* Serverless.com
* Terraform
* Cloud Shell

---
layout: four-cols-header
---

# IAC on other Clouds

::one::

![Local Image](aws-small.png)

* AWS Console
* APIs
* AWS CLI
* Cloud shell
* Cloud Formation
* Serverless
* Terraform
* CDK TF
* CDK

::two::

![Local Image](azure-small.png)

* Azure Portal
* APIs
* Cloud Shell
* AZ CLI
* Terraform
* ARM templates
* Blueprints

::three::

![Local Image](google-small.png)

* Google Portal
* Cloud Shell
* Google Cloud Deployment Manager
* Terraform

::four::

![Local Image](snowflake-small.png)

* Snowflake Portal
* Terraform

---

# Notable mentions

* Ansible
* Chef
* Puppet
* Vagrant

---
layout: two-cols-header
---

# Why CDK

::left::

![Local Image](aws-cdk.png)

::right::

* Not YAML or Json
* Choose a language
* AWS supported

---
layout: two-cols-header
---

# Where CDK fits in

::left::

![Local Image](cdk-fits.png)

---
layout: two-cols-header
---

# App / Stacks / Constructs

::left::

![Local Image](constructs.png)

::right::

App
* All stacks for the Application

Stacks
* Units of deployment

Constructs
* The AWS Resources

---

# CDK Levels

1. Level 1 - **Cfnxxx** - Direct AWS Resources
2. Level 2 - **Preferred level** - S3Bucket / Lambda
3. Level 3 - **Higher Constructs** - LambdaNodeJS / LoadBalancedFargateApp

---

# Session 1

* How to setup a new project
* Step 1 - Build the project
* Step 2 - Authenticate into AWS and run CDK Bootstrap
* Step 3 - Deploy the Stack into AWS
* Step 4 - Improve config and multi environments
* Step 5 - Pass configuration into the stack
* Step 6 - Deploy a lambda
* Step 7 - Give the Lambda access to a DynamoDB table
* Step 8 - Clean up

---

# Code Time

---

# Discussion points

* What to do next?
* How to pipeline
* CDK and serverless
* Production ready?

---
layout: two-cols-header
---

# Code

::left::

https://github.com/infinityworks/101-Sessions

::right::

![Local Image](qr-code.png)
