# Email - Preparation

Hi Everyone,

In the interests of getting the most out of the 101 Step Functions session, it would be great if you could do some preparation.

## Setup software

Check to see you have `GO`, `NPM` and `NODE` installed

```bash
go version
go version go1.11.4 linux/amd64
```

```bash
node -v
v8.10.0
```

```bash
npm -v
6.8.0
```

### Install Go

Create a `go directory` in your home folder 

* _OSX_ - /Users/steven/go
* _Linux_ - /home/steven/go

Download - https://golang.org/dl/

Get GO in your `PATH` and set your `GOPATH`

````bash
export GOPATH=~/go
````

### Install nodejs

_Linux_

```bash
 sudo apt install nodejs
 ```

 _macOS and Windows_

 <https://nodejs.org/en/download/>

### Install serverless

```bash
npm install --save-dev serverless
```

## Get access to an AWS Account 

(Free tier will work)
<https://aws.amazon.com/free/>

## Install AWS CLI

Aws cli allows you run run commands on your computer to interact directly with your AWS Account.

<https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html>

Create a Programmtaical `IAM User`, and add a profile for the AWS CLI to use

file `~/.aws/credentials`

```bash
[101profile]
aws_access_key_id     = YYYYYYYYYYYYYYYY
aws_secret_access_key = XXXXXXXXXXXXXXXXXX
```

Test that the AWS profile works with the `aws cli`

```bash
aws s3 ls --profile 101profile
```

> You should get no errors