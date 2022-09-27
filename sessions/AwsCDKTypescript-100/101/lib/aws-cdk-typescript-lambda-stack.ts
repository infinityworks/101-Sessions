import { CfnOutput, Stack, StackProps } from 'aws-cdk-lib'
import { Construct } from 'constructs'
import { join } from 'path'
import { Runtime, FunctionUrl, FunctionUrlAuthType } from "aws-cdk-lib/aws-lambda"
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs'


export interface CustomStackProps extends StackProps {
    environmentName: string
}

export class AwsCdkTypescriptStack extends Stack {
    constructor(scope: Construct, id: string, props: CustomStackProps) {
        super(scope, id, props)

        const helloWorld = new NodejsFunction(this, 'HelloWorldHandler', {
            runtime: Runtime.NODEJS_16_X,
            entry: join(__dirname, '../', 'lambdas', 'hello-world.ts'),
            depsLockFilePath: join(__dirname, '../', 'lambdas', 'package-lock.json'),
            memorySize: 1024,
            bundling: {
                externalModules: [
                    'aws-sdk', // Use the 'aws-sdk' available in the Lambda runtime
                ],
            },
            environment: {
                ENV_NAME : props.environmentName,
            }
        })

        const helloWorldUrl = new FunctionUrl(this, 'HelloWorldUrl', {
            function: helloWorld,
            authType: FunctionUrlAuthType.NONE,
        })

        new CfnOutput(this, 'Url', { value: helloWorldUrl.url })
    }
}
