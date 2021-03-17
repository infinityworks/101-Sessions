import type { Serverless } from "serverless/aws";

const serverlessConfiguration: Serverless = {
  service: {
    name: "aws-nodejs-typescript",
  },
  configValidationMode: "error",
  frameworkVersion: ">=1.72.0",
  custom: {
    webpack: {
      webpackConfig: "./webpack.config.js",
      includeModules: true,
    },
  },
  // Add the serverless-webpack plugin
  plugins: ["serverless-webpack"],
  provider: {
    name: "aws",
    runtime: "nodejs12.x",
    apiGateway: {
      minimumCompressionSize: 1024,
    },
    environment: {
      AWS_NODEJS_CONNECTION_REUSE_ENABLED: "1",
    },
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
          "Fn::GetAtt": ["dataTable", "Arn"],
        },
      },
      {
        Effect: "Allow",
        Action: ["firehose:PutRecord", "firehose:PutRecordBatch"],
        Resource:
          "arn:aws:firehose:us-east-1:180466524585:deliverystream/delivery-stream",
      },
      {
        Effect: "Allow",
        Action: ["events:PutEvents"],
        Resource: "*",
      }
    ],
  },
  functions: {
    dynamoPut: {
      handler: "handler.dynamoPut",
      events: [
        {
          http: {
            method: "get",
            path: "dynamoPut",
          },
        },
      ],
    },
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
  },
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
};

module.exports = serverlessConfiguration;
