import { Stack, StackProps } from 'aws-cdk-lib'
import { Construct } from 'constructs'

export interface CustomStackProps extends StackProps {
    environmentName: string
}

export class AwsCdkTypescriptStack extends Stack {
    constructor(scope: Construct, id: string, props?: CustomStackProps) {
        super(scope, id, props)
    }
}
