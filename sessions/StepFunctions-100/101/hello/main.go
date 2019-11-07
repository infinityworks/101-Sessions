package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// MyEvent stuff
type MyEvent struct {
	Name string `json:"name"`
}

// HandleRequest the method that recieves the step call
func HandleRequest(ctx context.Context, name MyEvent) (string, error) {
	return fmt.Sprintf("Hello 101 Class"), nil
}

func main() {
	lambda.Start(HandleRequest)
}
