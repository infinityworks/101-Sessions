import { APIGatewayEvent, APIGatewayProxyResult } from "aws-lambda"

const environmentName = process.env.ENV_NAME

export const handler = async (event: APIGatewayEvent): Promise<APIGatewayProxyResult> => {
    try {
        const method = event.httpMethod
        const path = event.path
        const forwardedForHeader = (event.headers || {})["X-Forwarded-For"] || "not found"
        const sourceIp = forwardedForHeader.split(', ')[0]

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

        // Only accept GET for now.
        return {
            statusCode: 400,
            headers: {},
            body: `We only accept GET / <br>received event ${JSON.stringify(event)}`
        }
    } catch (error) {
        return {
            statusCode: 400,
            headers: {},
            body: JSON.stringify(JSON.stringify(error, null, 2))
        }
    }
}
