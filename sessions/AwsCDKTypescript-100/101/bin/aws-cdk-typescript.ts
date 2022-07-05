#!/usr/bin/env node
import 'source-map-support/register'
import { App } from 'aws-cdk-lib'
import { AwsCdkTypescriptStack } from '../lib/aws-cdk-typescript-empty-stack'

function getAccount(): string {
    switch (process.env.AWS_ENVIRONMENT) {
        case 'DEVELOPMENT':
            return '123451234512'
        case 'TESTING':
            return '0123456788'
        case 'PRODUCTION':
            return '0123456789'
    }
    throw new Error('unknown environment')
}

const app = new App()
new AwsCdkTypescriptStack(app, 'AwsCdkTypescriptStack', {
    env: { account: getAccount(), region: 'us-east-1' },
})
