# Create the project

> This step is how to start a new project and is not needed

```shell
# Initialize the project.
npx cdk init --language=typescript
# Install esbuild to optimise build times.
# Without esbuild, CDK uses Docker to build TypeScript Lambda functions.
npm install --save-dev esbuild
```

## Bootstrap

Bootstrapping configures your AWS environment to support CDK operations.

```shell
npx cdk bootstrap
```

If you're not logged in to AWS, you'll get the error:

```shell
Unable to resolve AWS account to use. It must be either configured when you define your CDK Stack, or through the environment
```

## Deploy

```shell
npx cdk deploy --all
```

The `cdk.json` file tells the CDK Toolkit how to execute your app.

## Useful commands

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `cdk deploy`      deploy this stack to your default AWS account/region
* `cdk diff`        compare deployed stack with current state
* `cdk synth`       emits the synthesized CloudFormation template
