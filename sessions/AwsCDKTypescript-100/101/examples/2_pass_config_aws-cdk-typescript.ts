#!/usr/bin/env node
import 'source-map-support/register'
import { App } from 'aws-cdk-lib'
import { AwsCdkTypescriptStack } from '../lib/aws-cdk-typescript-config-stack'
import * as environments from  '../lib/aws-environments'

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
            awsAccountNumber: environments.AWS_ENV_DEV,
            mainRegion: 'us-east-1',
        }

        case 'PRODUCTION':
        return {
            environmentName: 'Prod',
            awsAccountNumber: environments.AWS_ENV_PROD,
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
