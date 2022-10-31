import { APIGatewayProxyEventV2, APIGatewayProxyResultV2 } from 'aws-lambda';

const environmentName = process.env.ENV_NAME

interface Message {
    message: string
}

export const handler = async (event: APIGatewayProxyEventV2): Promise<APIGatewayProxyResultV2<Message>> => {
    try {
        const method = event.requestContext.http.method
        const path = event.requestContext.http.path
        const forwardedForHeader = (event.headers || {})["X-Forwarded-For"] || event.requestContext.http.sourceIp
        const sourceIp = forwardedForHeader.split(', ')[0]

        if (method === "GET") {
            if (path === "/") {
                return {
                    message: `hello ${sourceIp} from ${environmentName}`
                }
            }
        }

        // Only accept GET for now.
        return {
            statusCode: 400,
            body: `We only accept GET - received event: ${JSON.stringify(event)}`
        }
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify(JSON.stringify(error, null, 2))
        }
    }
}
