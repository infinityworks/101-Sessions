package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// HandleRequest the method that recieves the step call
func HandleRequest(ctx context.Context, cwEvent events.CloudWatchEvent) (string, error) {
	fmt.Printf("Processing Item (logged to cloudwatch) %v ", string(cwEvent.Detail))
	return fmt.Sprintf("Processing Item %v ", string(cwEvent.Detail)), nil
}

func main() {
	lambda.Start(HandleRequest)
}
