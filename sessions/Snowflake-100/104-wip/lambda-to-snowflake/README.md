# Lambda to Snowflake

## Start a serverless project:

```
npx serverless create --template=aws-nodejs-typescript
```

## Install all the packages

```
npm install
```

## Deploy the function

```
npx serverless deploy
```

Every time you make changes, you'll need to do this.

## Install the AWS SDK

```
npm install --save aws-sdk
```

## Add a handler that publishes to EventBridge

* Update the IAM role to enable the Lambda function permission to publish events.
* Customise the data that's passed to EventBridge.
* Set the source and detail types in serverless.ts
* Note that there's a default EventBridge in every account. If you don't pass a name, it's assumed that you're using the default one.
* Add the handler code to handler.ts

```
publishToEventBridge: {
  handler: "handler.publishToEventBridge",
  events: [
    {
      http: {
        method: "get",
        path: "publish",
      },
    },
  ],
},
```

```
const eb = new AWS.EventBridge();
await eb
  .putEvents({
    Entries: [
      {
        Source: "publishToEventBridge",
        DetailType: "secondsEvent",
        Detail: JSON.stringify({ value: secondsInMinute } as SecondsEvent),
      },
    ],
  })
  .promise();
```

## Create a Firehose to push data to S3

* Do this in the console.

## Add a handler to subscribe to EventBridge events and push them to Firehose

* Update the IAM role to allow publishing to Firehose
* Access your publishToEventBridge handler and check that the data ends up in S3, it might take a few minutes
* Set up the function in serverless.ts
* Add your handler code in handler.ts

```
eventBridgeHandler: {
  handler: "handler.eventBridgeHandler",
  events: [
    {
      eventBridge: {
        pattern: {
          source: ["publishToEventBridge"],
          "detail-type": ["secondsEvent"],
        },
      },
    },
  ],
},
```

```
const fh = new AWS.Firehose();
await fh.putRecord({ DeliveryStreamName: "delivery-stream", Record: { Data: JSON.stringify({ x: 1 }) } }).promise();
```

# Optional

Subscribe to DynamoDB streams and take a copy of data in DynamoDB for your data lake.

## Add a DynamoDB table

```
resources: {
  Resources: {
    dataTable: {
      Type: "AWS::DynamoDB::Table",
      Properties: {
        AttributeDefinitions: [
          {
            AttributeName: "_id",
            AttributeType: "S",
          },
          {
            AttributeName: "_rng",
            AttributeType: "S",
          },
        ],
        KeySchema: [
          {
            AttributeName: "_id",
            KeyType: "HASH",
          },
          {
            AttributeName: "_rng",
            KeyType: "RANGE",
          },
        ],
        BillingMode: "PAY_PER_REQUEST",
        TableName: "dataTable",
      },
    },
  },
},
```

## Ensure the function has permission to write to the table

```
iamRoleStatements: [
  {
    Effect: "Allow",
    Action: [
    "dynamodb:DescribeTable",
    "dynamodb:DescribeTable",
    "dynamodb:Query",
    "dynamodb:Scan",
    "dynamodb:GetItem",
    "dynamodb:PutItem",
    "dynamodb:UpdateItem",
    "dynamodb:DeleteItem",
    ],
    Resource: {
      "Fn::GetAtt": [ "dataTable", "Arn" ]
    },
  },
],
```

## Write to DynamoDB

```js
const client = new AWS.DynamoDB.DocumentClient();
await client
  .put({
    TableName: "dataTable",
    Item: { _id: new Date().toISOString(), _rng: "value" },
  })
  .promise();
```
