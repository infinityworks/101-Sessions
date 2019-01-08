AWS CLI Setup


Setup Admin User with Key and Secret
https://docs.aws.amazon.com/lambda/latest/dg/setup.html#setting-up


https://docs.aws.amazon.com/lambda/latest/dg/setup-awscli.html

Serverless CLI Setup



https://poolieweb.signin.aws.amazon.com/console


aws help

aws lambda list-functions --profile poolieweb

https://serverless.com/framework/docs/providers/aws/guide/installation/

npm install -g serverless

serverless

sls

sls create --template aws-nodejs

delete comments and add region eu-west-2

sls deploy --verbose --aws-profile=poolieweb

sls invoke --function hello --aws-profile=poolieweb

make change to function

sls invoke local --function hello

sls deploy function --function hello --verbose --aws-profile=poolieweb

sls deploy --verbose --aws-profile=poolieweb


serverless logs -f hello -t --aws-profile=poolieweb

sls invoke --function hello --aws-profile=poolieweb


let look at the console.

https://eu-west-2.console.aws.amazon.com/lambda/home?region=eu-west-2#/functions

Test the lambda

Go back and add get 

sls deploy --verbose --aws-profile=poolieweb

Test url

show in console the api input

Debug

VS Code debug profile 





----

https://github.com/serverless/examples

