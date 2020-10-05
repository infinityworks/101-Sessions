# 103 - Lambda to Snowflake

In the lambda-to-snowflake directory, there's an example Serverless Framework project that demonstrates the use of an event dirven architecture.

First, an API publishes an event to EventBridge. Second, a Lambda subscribes to the Events and pushes them to Firehose. Finally, Kinesis Firehose buffers the data and places it into S3.

* API Gateway -> Lambda -> EventBridge -> Lambda -> Kinesis Firehose -> S3
