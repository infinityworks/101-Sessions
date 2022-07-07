import * as AWS from 'aws-sdk';
import { v4 as uuidv4 } from 'uuid';

const environmentName = process.env.ENV_NAME
const storeTableName = process.env.STORE_TABLE_NAME || ''
const docClient = new AWS.DynamoDB.DocumentClient();

export const handler = async (event: any = {}): Promise<any> => {

    try {
        var method = event.requestContext.http.method
        var path = event.requestContext.http.path
        var sourceIp = event.requestContext.http.sourceIp

        if (method === "GET") {
            if (path === "/") {
                var body = {
                    message: `hello ${sourceIp} from ${environmentName}`
                }
                return {
                    statusCode: 200,
                    headers: {},
                    body: JSON.stringify(body)
                }
            }
        }

        if (method === "POST") {
            const params = {
                TableName : storeTableName,
                Item: {
                   id: `${uuidv4()}`,
                   ipAddress: `${sourceIp}`
                }
            }

            await docClient.put(params).promise()

            var body = {
                message: `Stored ${sourceIp} in ${storeTableName}`
            }
            return {
                statusCode: 200,
                headers: {},
                body: JSON.stringify(body)
            }
        }

        // We only accept GET or POST for now
        return {
            statusCode: 400,
            headers: {},
            body: `We only accept GET or POST / <br>received event ${JSON.stringify(event)}`
        }
    } catch(error) {
        return {
            statusCode: 400,
            headers: {},
            body: JSON.stringify(JSON.stringify(error, null, 2))
        }
    }
}