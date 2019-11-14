package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// Item an event to hold an Item
type Item struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	Quantity int    `json:"quantity"`
}

// ItemEvent an event to hold the whole object
type ItemEvent struct {
	Item        Item
	Platform    string `json:"platform"`
	Ordernumber int    `json:"ordernumber"`
}

// HandleRequest the method that recieves the step call
func HandleRequest(ctx context.Context, itemEvent ItemEvent) (string, error) {
	fmt.Printf("Processing Item (logged to cloudwatch) %v %v %v %v %v", itemEvent.Platform, itemEvent.Ordernumber, itemEvent.Item.ID, itemEvent.Item.Name, itemEvent.Item.Quantity)
	// This could email out this token as a URL to click on in an Email.
	return fmt.Sprintf("Processing Item %v %v %v %v %v", itemEvent.Platform, itemEvent.Ordernumber, itemEvent.Item.ID, itemEvent.Item.Name, itemEvent.Item.Quantity), nil
}

func main() {
	lambda.Start(HandleRequest)
}
