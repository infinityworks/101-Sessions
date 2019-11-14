package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// WaitEvent an event to make the token accessible
type WaitEvent struct {
	Token string `json:"token"`
}

// HandleRequest the method that recieves the step call
func HandleRequest(ctx context.Context, waitEvent WaitEvent) (string, error) {
	fmt.Printf("Waiting for token (logged to cloudwatch) %v", waitEvent.Token)
	// This could email out this token as a URL to click on in an Email.
	return fmt.Sprintf("Waiting for token %v", waitEvent.Token), nil
}

func main() {
	lambda.Start(HandleRequest)
}
