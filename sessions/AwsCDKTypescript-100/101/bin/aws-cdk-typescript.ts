#!/usr/bin/env node
import 'source-map-support/register'
import { App } from 'aws-cdk-lib'
import { AwsCdkTypescriptStack } from '../lib/aws-cdk-typescript-empty-stack'
import * as environments from '../lib/aws-environments'

function getAccount(): string {
    switch (process.env.AWS_ENVIRONMENT) {
        case 'DEVELOPMENT':
            return environments.AWS_ENV_DEV
        case 'PRODUCTION':
            return environments.AWS_ENV_PROD
    }
    throw new Error('unknown environment')
}

const app = new App()
new AwsCdkTypescriptStack(app, `AwsCdkTypescriptStack-${process.env.STACK_SUFFIX}`, {
    env: { account: getAccount(), region: 'us-east-1' },
})
