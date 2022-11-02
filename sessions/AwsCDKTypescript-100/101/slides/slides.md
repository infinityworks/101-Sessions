# AWS CDK Typescript

Steven Harper & Adrian Hesketh

https://infinityworks.com

---

# What is Infrastructure as Code (IAC)

* <mdi-check-circle class="text-green-400" /> Express environments & resources in “code”
  * S3 Buckets, EC2 Instances, Database Servers, Lambda Functions
* <mdi-check-circle class="text-green-400" /> Repeatable outcomes, when creating resources
  * Desired state vs Imperative
  * *"There should be a database server"* vs *"Create a database server"*
* <mdi-check-circle class="text-green-400" /> Reduce human error when making changes
  * Allows automation via CI/CD
* <mdi-check-circle class="text-green-400" /> Allows versioning, and rollback
  * It is just text in a git repository

---
layout: two-cols-header
---

# Early AWS

::left::

![Local Image](aws-cloud.png)

::right::

* AWS Console
* APIs
* AWS CLI
* Cloud Formation

---
layout: two-cols
---

# Time to get cloudy

* Terraform (2014)
  * <mdi-check-circle class="text-green-400" /> Uses AWS SDK directly
  * <mdi-check-circle class="text-green-400" /> Written in Go
  * <mdi-check-circle class="text-green-400" /> Module ecosystem
  * <mdi-check-circle class="text-green-400" /> Build for GCP, Azure, AWS and more
* Serverless Framework (2015)
  * <mdi-check-circle class="text-green-400" /> Based on CloudFormation
  * <mdi-check-circle class="text-green-400" /> Written in JavaScript
  * <mdi-check-circle class="text-green-400" /> Plugin ecosystem
* AWS SAM (2016)
  * <mdi-check-circle class="text-green-400" /> Based on CloudFormation
  * <mdi-check-circle class="text-green-400" /> Extends CloudFormation
  * <mdi-check-circle class="text-green-400" /> Written in Python

::right::

* Pulumi (2018)
  * <mdi-check-circle class="text-green-400" /> Same as CDK
  * <mdi-check-circle class="text-green-400" /> Build for GCP, Azure, AWS
* AWS CDK (2019)
  * <mdi-check-circle class="text-green-400" /> TypeScript / Go / Node.js / etc.
  * <mdi-check-circle class="text-green-400" /> Based on CloudFormation
  * <mdi-check-circle class="text-green-400" /> High level abstractions
  * <mdi-check-circle class="text-green-400" /> Suitable for infrastructure projects too
* CDKTF (2020)
  * <mdi-check-circle class="text-green-400" /> TypeScript / Go / Node.js / etc.
  * <mdi-check-circle class="text-green-400" /> Based on Terraform
  * <mdi-check-circle class="text-green-400" /> Use Terraform modules
  * <mdi-check-circle class="text-green-400" /> Build for GCP, Azure, AWS, and more

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
* CDK TF & CDK

::two::

![Local Image](azure-small.png)

* Azure Portal
* APIs
* Cloud Shell
* AZ CLI
* Terraform
* ARM templates
* Blueprints
* CDK TF

::three::

![Local Image](google-small.png)

* Google Portal
* Cloud Shell
* Google Cloud Deployment Manager
* Terraform
* CDK TF

::four::

![Local Image](snowflake-small.png)

* Snowflake Portal
* Terraform
* CDK TF

---

# Notable mentions

Prior to serverless, your infrastructure changed less often.

* Ansible
* Chef
* Puppet
* Vagrant
* Salt stack

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

* Level 1
  * **Cfnxxx** - Direct AWS Resources
* Level 2
  * **Preferred level** - S3Bucket / Lambda
* Level 3
  * **Higher Constructs** - LambdaNodeJS / LoadBalancedFargateApp

---

# Session 1

* How to setup a new project
* Step 1 - Build the project
* Step 2 - Authenticate into AWS and run CDK Bootstrap
* Step 3 - Deploy the Stack into AWS
* Step 4 - Improve config and multi environments
* Step 5 - Pass configuration into the stack
* Step 6 - Deploy a Lambda Function
* Step 7 - Give the Lambda Function access to a DynamoDB table
* Step 8 - Clean up

---
layout: two-cols-header
---

# Code Time

::left::

https://github.com/infinityworks/101-Sessions

You can get help from the helpers around the room

::right::

![Local Image](qr-code.png)

---

# Lean Coffee

* Lets vote on what to chat about

---
layout: two-cols-header
---

# Code

::left::

https://github.com/infinityworks/101-Sessions

::right::

![Local Image](qr-code.png)
