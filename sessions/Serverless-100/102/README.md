# Serverless 102 

The cat-app contains a folder with a simple application designed to run on a traditional 24/7 server. We are going to make it serverless!

## Task 1

> 1) Describe the API using a serverless.yml file
> 2) Make the minimum modifications to the application to make it run in AWS
> 3) Deploy

Use the [template provided by Serverless](https://github.com/serverless/serverless/blob/master/lib/plugins/create/templates/aws-nodejs/serverless.yml) to help you.

Your file should, at a minimum:
* define a service name
* set a provider and a runtime
* select an aws region (eu-west-2 is London)
* have at least one function
  * pointing at a file and export name which will run (the handler)
  * with a http event to trigger it

It may help you to know that a http event that will catch all routes and methods looks like this:
```yaml
- http:
    path: /{any+}
    method: ANY
```

The easiest way to convert an express server to serverless is to use the [serverless-http](https://www.npmjs.com/package/serverless-http) module.

Install it like this:
```
npm install serverless-http
```
Use it like this:
```js
const serverless = require('serverless-http')

...

// 'app' is the instance of express, which is defined already in app.js
module.exports.myHandlerName = serverless(app);
```

You can deploy your full app with:
```
serverless deploy 
```
You can re-deploy a single function with:
```
serverless deploy -f yourfunctionname
```
(the name is the _key_ defining the function in the `function` block of `serverless.yml`. This is 'hello' in the serverless template linked to above.)

Once deployed, see if it works! The serverless deploy command will give you an address of an API gateway instance such as `https://q869xtluei.execute-api.eu-west-1.amazonaws.com/dev`. Open this in a web browser and append `index.html`

(ie. it should like like: `https://q869xtluei.execute-api.eu-west-1.amazonaws.com/dev/index.html`)


## Task 2

> Remove the stateful tracking of the last cat image returned by offloading it to the client

An express handler that reads and writes a cookie might look like this:
```js
app.get('hello/', (req, res) => {
    // Get a cookie and store it in a variable.
    let cookieValue = req.cookies.myCookieA;
    // Set a different cookie to a random number.
    res.cookie('myCookieB', Math.random());
})
```

Use this in the `/cats/random` route to store the index of the last cat returned in a cookie.

## Task 3

> Break out the storage of the cat images to an S3 bucket:
> 
> 1. Create an S3 bucket in the resources section of serverless.yml
> 2. Give the lambda permission to list files and get and put files to that bucket
> 3. Refactor `cats.js` to use the S3 APIs for getting, putting and listing images

A full example of defining an S3 bucket can be found in the serverless template from part 1

A minimal S3 bucket definition looks like this:
```yml
resources:
    Resources:
        NameOfBucketWithinThisFile:
            Type: AWS::S3::Bucket
            Properties:
                BucketName: name-of-bucket-on-aws
```

We can add permissions to a lambda to access this bucket as follows:
```yml
    iamRoleStatements:
        - Effect: "Allow"
            Action: 
                - s3:PutObject
                - s3:GetObject
            Resource: "arn:aws:s3:::name-of-bucket-on-aws/*"
        - Effect: "Allow"
            Action: 
                - s3:ListBucket
            Resource: "arn:aws:s3:::name-of-bucket-on-aws"
```
(add the above block inside the provider block or inside a single function definition)

The three important S3 functions for us are:
* [getObject()](https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#getObject-property)
* [putObject()](https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#putObject-property)
* [listObjects()](https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#listObjects-property)

By default the accept callbacks. You can make them return a `promise` as in the following example:
```js
const writeToS3AndReturnPromise = () => {
    var s3 = new AWS.S3();
    return s3.putObject({
        Bucket: 'name-of-bucket',
        Key: 'myFile.txt',
        Body: "This is the contents of my text file",
    }).promise();
};
```

## Task 4

> Migrate the static html and client-side javascript to another S3 bucket
>
> 1) Create a new S3 bucket that can be publicly read
> 2) Use the `serverless-s3-sync` plugin to synchronise the local files to the bucket

A public S3 bucket can be created like so:
```yml
resources:
    Resources:
        NameOfBucketWithinThisFile:
            Type: AWS::S3::Bucket
            Properties:
                BucketName: name-of-bucket-on-aws
                AccessControl: PublicRead
                WebsiteConfiguration:
                    IndexDocument: index.html
```

We can send files to this bucket at deploy time with the plugin [serverless-s3-sync](https://github.com/k1LoW/serverless-s3-sync)

Install it like this:
```
serverless plugin install -n serverless-s3-sync
```

Include the following two blocks in your serverless.yml to use it:

```yml
plugins:
  - serverless-s3-sync
```

```yml
custom:
    s3Sync:
        - bucketName: my-static-site-assets # required
            localDir: dist/assets # required
            acl: public-read # optional
            defaultContentType: text/html # optional
            params: # optional
                - index.html:
                    CacheControl: 'no-cache'
                - "*.js":
                    CacheControl: 'public, max-age=31536000'
```

You can find your S3 bucket in your AWS web console and get the URL of the index.html file from there.

Your API will stop working as the client-side JS is expecting an API on the same domain. You will have to hard-code the address of your API gateway to make this work.