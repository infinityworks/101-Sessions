# 102 Step Functions - Infinity Works 

This is the 2nd part of the Step Functions course.
You will need to setup the project by following the setup in the [101 README](../101/README.md)

## Outline

* First Step Machine : iw102StarterMachine

### Location of this checked out code

Because this is a go project, it must be checked out (or linked) within your go/src directory.

Copy or Link this project to

`~/go/src/github.com/102-step-functions/`

How to Link it

```bash
mkdir -p ~/go/src/github.com/
mkdir ~/code
cd ~/code
git clone git@github.com:infinityworks/101-Sessions.git
cd ~/go/src/github.com
ln -s ~/code/101-Sessions/sessions/StepFunctions-100/102 102-step-functions
```

## First Step Machine : iw102StarterMachine

Copy the contents of the file : see [./saved-steps/serverless-01-starter.yml](./saved-steps/serverless-01-starter.yml) over the `./serverless.yml` file.

So it's time to actually deploy this:

```bash
make deploy STAGE=dev
```

> You can Invoke a step function from the CLI

```bash
sls invoke stepf --name <stepfunctionname> --data '{"foo":"bar"}'
```

## API Triggers

```yml
stepFunctions:
  stateMachines:
    hello:
      events:
        - http:
            path: hello
            method: GET
        - http:
            path: action/start
            method: POST
        - http:
            path: action/status
            method: POST
            action: DescribeExecution
        - http:
            path: action/stop
            method: POST
            action: StopExecution
      definition:
```

## CloudWatch Notifications

You can monitor the execution state of your state machines via CloudWatch Events. It allows you to be alerted when the status of your state machine changes to `ABORTED`, `FAILED`, `RUNNING`, `SUCCEEDED` or `TIMED_OUT`.

```yml
stepFunctions:
  stateMachines:
    hellostepfunc1:
      name: test
      definition:
        ...
      notifications:
        ABORTED:
          - sns: SNS_TOPIC_ARN
          - sqs: SQS_TOPIC_ARN
          - sqs: # for FIFO queues, which requires you to configure the message group ID
              arn: SQS_TOPIC_ARN
              messageGroupId: 12345
          - lambda: LAMBDA_FUNCTION_ARN
          - kinesis: KINESIS_STREAM_ARN
          - kinesis:
               arn: KINESIS_STREAM_ARN
               partitionKeyPath: $.id # used to choose the parition key from payload
          - firehose: FIREHOSE_STREAM_ARN
          - stepFunctions: STATE_MACHINE_ARN
        FAILED:
```