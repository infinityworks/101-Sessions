import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda'
import * as db from './db'

const environmentName = process.env.ENV_NAME

interface Message {
    message: string
}

export const handler = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2<Message>> => {
    try {
        const forwardedForHeader = (event.headers || {})["X-Forwarded-For"] || event.requestContext.http.sourceIp
        const sourceIp = forwardedForHeader.split(', ')[0]

        switch (event.requestContext.http.method) {
            case "GET":
                return {
                    message: `hello ${sourceIp} from ${environmentName}`
                }
            case "POST":
                await db.storeIpAddress(sourceIp)
                return {
                    message: `Stored ${sourceIp} in DynamoDB`
                }
        }

        return {
            statusCode: 400,
            body: `We only accept GET or POST / received event: ${JSON.stringify(event)}`
        }
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify(JSON.stringify(error, null, 2))
        }
    }
}
