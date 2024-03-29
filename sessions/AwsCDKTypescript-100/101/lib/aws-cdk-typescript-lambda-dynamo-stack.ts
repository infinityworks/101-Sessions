import { CfnOutput, RemovalPolicy, Stack, StackProps } from 'aws-cdk-lib'
import { Construct } from 'constructs'
import { join } from 'path'
import { Runtime, FunctionUrlAuthType, FunctionUrl } from "aws-cdk-lib/aws-lambda"
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs'
import { AttributeType, BillingMode, Table } from 'aws-cdk-lib/aws-dynamodb'

export interface CustomStackProps extends StackProps {
    environmentName: string
}

export class AwsCdkTypescriptStack extends Stack {
    constructor(scope: Construct, id: string, props: CustomStackProps) {
        super(scope, id, props)

        const table = new Table(this, 'Store', {
            billingMode: BillingMode.PAY_PER_REQUEST,
            removalPolicy: RemovalPolicy.DESTROY,
            partitionKey: {
                name: 'id',
                type: AttributeType.STRING,
            },
            sortKey: {
                name: 'ipAddress',
                type: AttributeType.STRING,
            },
        })

        const helloWorld = new NodejsFunction(this, 'HelloWorldHandler', {
            runtime: Runtime.NODEJS_14_X,
            entry: join(__dirname, '../', 'lambdas', 'hello-world-store.ts'),
            memorySize: 1024,
            bundling: {
                externalModules: [
                    'aws-sdk', // Use the 'aws-sdk' available in the Lambda runtime
                ],
            },
            environment: {
                ENV_NAME: props.environmentName,
                STORE_TABLE_NAME: table.tableName,
            }
        })
        table.grantWriteData(helloWorld)
        const helloWorldUrl = new FunctionUrl(this, 'HelloWorldUrl', {
            function: helloWorld,
            authType: FunctionUrlAuthType.NONE,
        })

        new CfnOutput(this, 'Url', { value: helloWorldUrl.url })
    }
}
