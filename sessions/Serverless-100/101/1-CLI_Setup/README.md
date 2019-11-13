# Serverless AWS CLI Setup


## Setup Admin User with Key and Secret
https://docs.aws.amazon.com/lambda/latest/dg/setup.html#setting-up

Optional : bookmark url to your account console login
https://poolieweb.signin.aws.amazon.com/console

https://docs.aws.amazon.com/lambda/latest/dg/setup-awscli.html

## Serverless CLI Setup

Test the AWS CLI and account details
```
aws help
```

Test you have admin rights to view lambda in AWS
```
aws lambda list-functions --profile poolieweb
```

Install the Serverless framework
```
npm install -g serverless
```
https://serverless.com/framework/docs/providers/aws/guide/installation/

Test Serverless CLI

```
serverless
```
Short notation for "serverless command"
```
sls
```
Create a folder and run the following command with the folder to create a template
```
sls create --template aws-nodejs
```

Delete comments and add region eu-west-2, should look like the below
```
provider:
  name: aws
  runtime: nodejs8.10
  region: eu-west-2
```
Lets deploy the application
```
sls deploy --verbose --aws-profile=poolieweb
```
Let invoke the lambda from the CLI
```
sls invoke --function hello --aws-profile=poolieweb
```

Make a change to the function code and invoke without deploying

```
sls invoke local --function hello
```

Deploy just the single function that has changed

```
sls deploy function --function hello --verbose --aws-profile=poolieweb
```

Which is different to deploying the stack / application

```
sls deploy --verbose --aws-profile=poolieweb
```

Lets do some logging

```
serverless logs -f hello -t --aws-profile=poolieweb
```

Open a new terminal session and invoke

```
sls invoke --function hello --aws-profile=poolieweb
```


Lets look at the console.

https://eu-west-2.console.aws.amazon.com/lambda/home?region=eu-west-2#/functions

Test the lambda in the console

Lets add a basic ```Get``` endpoint

```
functions:
  hello:
    handler: handler.hello
    events:
      - http: GET hello
```
And deploy

```
sls deploy --verbose --aws-profile=poolieweb
```

url of the ```GET``` should be in the console

```
endpoints:
  GET - https://wyev2f3ywj.execute-api.eu-west-2.amazonaws.com/dev/hello
```

Lets have a look in the console

https://eu-west-2.console.aws.amazon.com/apigateway/home?region=eu-west-2#/apis

## Debug
### VS Code debug profile

Click on the debug icon on the side bar in Visual Studio Code.

Add a configuration can edit like the example below:
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "Launch Serverless Offline",
            "program": "/usr/local/bin/sls",
            "args": [
                "invoke",
                "local",
                "-f",
                "hello",
                "--data",
                "{}"
            ]
        }
    ]
}
```

https://github.com/serverless/examples

