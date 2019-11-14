package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// ItemEvent an event to hold an Item
type ItemEvent struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	Quantity int    `json:"quantity"`
}

// HandleRequest the method that recieves the step call
func HandleRequest(ctx context.Context, itemEvent ItemEvent) (string, error) {
	fmt.Printf("Processing Item (logged to cloudwatch) %v %v %v", itemEvent.ID, itemEvent.Name, itemEvent.Quantity)
	// This could email out this token as a URL to click on in an Email.
	return fmt.Sprintf("Processing Item %v %v %v", itemEvent.ID, itemEvent.Name, itemEvent.Quantity), nil
}

func main() {
	lambda.Start(HandleRequest)
}
