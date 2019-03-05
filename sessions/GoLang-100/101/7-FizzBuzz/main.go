package main

import (
	"fmt"
	"strconv"

	flag "github.com/ogier/pflag"
)

var (
	fizzBuzzNumber int
)

func main() {
	flag.Parse()
	fmt.Println(fizzBuzz(fizzBuzzNumber))
}

func init() {
	flag.IntVarP(&fizzBuzzNumber, "number", "n", 0, "Is it Fizz or Buzz !!")
}

func fizzBuzz(n int) string {
	result := ""
	if n%3 == 0 {
		result += "Fizz"
	}
	if n%5 == 0 {
		result += "Buzz"
	}
	if result != "" && n != 0 {
		return result
	}
	return strconv.Itoa(n)
}

// $ go get github.com/ogier/pflag

// $ go run fizzBuzz.go -n 3
// Fizz
