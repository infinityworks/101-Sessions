#!/usr/bin/env node
import 'source-map-support/register'
import { App } from 'aws-cdk-lib'
import { AwsCdkTypescriptStack } from '../lib/aws-cdk-typescript-config-stack'

export interface AppConfig {
    awsAccountNumber: string
    mainRegion: string
    environmentName: string
}

const getConfig = ():AppConfig => {
    switch (process.env.AWS_ENVIRONMENT) {
        case 'DEVELOPMENT':
        return {
            environmentName: 'Dev',
            awsAccountNumber: '123451234512',
            mainRegion: 'us-east-1',
        }

        case 'PRODUCTION':
        return {
            environmentName: 'Prod',
            awsAccountNumber: '123451234512',
            mainRegion: 'eu-central-1',
        }
    }
    throw new Error('unknown environment')
}

const currentConfig = getConfig()

const app = new App()
new AwsCdkTypescriptStack(app, `AwsCdkTypescriptStack${currentConfig.environmentName}`, {
    env: { account: currentConfig.awsAccountNumber, region: currentConfig.mainRegion },
    environmentName: currentConfig.environmentName,
})
