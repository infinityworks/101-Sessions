package main

import (
	"context"
	"errors"
	"fmt"
	"math/rand"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

// MyEvent stuff
type MyEvent struct {
	Name string `json:"name"`
}

// CustomError smaple error
type CustomError struct{}

func (e *CustomError) Error() string {
	return "bad stuff happened..."
}

// HandleRequest the method that recieves the step call
func HandleRequest(ctx context.Context, name MyEvent) (string, error) {

	rand.Seed(time.Now().UnixNano())
	numb := rand.Intn(100)

	if numb < 51 {
		return "", errors.New("something went wrong")
	}
	if numb < 91 {
		return "", &CustomError{}
	}
	return fmt.Sprintf("Super Happy Success"), nil
}

func main() {
	lambda.Start(HandleRequest)
}
