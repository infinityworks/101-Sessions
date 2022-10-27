import * as AWS from 'aws-sdk';
import { v4 as uuidv4 } from 'uuid';

const storeTableName = process.env.STORE_TABLE_NAME || ''
const docClient = new AWS.DynamoDB.DocumentClient();

export async function storeIpAddress(ip: string): Promise<void> {
    const params = {
        TableName: storeTableName,
        Item: {
            id: `${uuidv4()}`,
            ipAddress: `${ip}`
        }
    }

    await docClient.put(params).promise()
}
