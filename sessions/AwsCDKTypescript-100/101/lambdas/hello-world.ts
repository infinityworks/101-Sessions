import * as AWS from 'aws-sdk';

const environmentName = process.env.ENV_NAME

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

        // We only accept GET for now
        return {
            statusCode: 400,
            headers: {},
            body: `We only accept GET / <br>received event ${JSON.stringify(event)}`
        }
    } catch(error) {
        return {
            statusCode: 400,
            headers: {},
            body: JSON.stringify(JSON.stringify(error, null, 2))
        }
    }
}