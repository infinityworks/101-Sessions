import { APIGatewayProxyHandler, EventBridgeHandler } from "aws-lambda";
import "source-map-support/register";
import * as AWS from "aws-sdk";

export const dynamoPut: APIGatewayProxyHandler = async (_event, _context) => {
  const client = new AWS.DynamoDB.DocumentClient();
  await client
    .put({
      TableName: "dataTable",
      Item: { _id: new Date().toISOString(), _rng: "value" },
    })
    .promise();

  return {
    statusCode: 200,
    body: JSON.stringify({ ok: true }),
  };
};

export const publishToEventBridge: APIGatewayProxyHandler = async (
  _event,
  _context
) => {
  const secondsInMinute = new Date().getSeconds();
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
  return {
    statusCode: 200,
    body: JSON.stringify({ ok: true }),
  };
};

interface SecondsEvent {
  value: number;
}

export const eventBridgeHandler: EventBridgeHandler<
  "secondsEvent",
  SecondsEvent,
  any
> = async (event, _context) => {
  console.log(JSON.stringify(event.detail));
  const fh = new AWS.Firehose();
  await fh
    .putRecord({
      DeliveryStreamName: "delivery-stream", //TODO: Use the name of your stream.
      Record: { Data: JSON.stringify(event.detail) },
    })
    .promise();
};
