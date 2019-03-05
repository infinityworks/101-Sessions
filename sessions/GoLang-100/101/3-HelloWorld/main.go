package main

import (
	"fmt"
	"math"
)

const thisIsAConstant string = "hello"

func main() {
	fmt.Println(thisIsAConstant)

	const n = 101
	fmt.Println(n)
	fmt.Println(math.Sin(n))

	var a = "Hello World"
	fmt.Println(a)

	// var b, c int = 1, 2
	var b, c = 1, 2
	fmt.Println(b, c)

	var d = true
	fmt.Println(d)

	// Variables declared without a corresponding initialization are zero-valued. For example, the zero value for an int is 0.
	var e int
	fmt.Println(e)

	// The := syntax is shorthand for declaring and initializing a variable, e.g. for var f string = "short" in this case.
	f := "short"
	f = "long"
	// f := "short"
	fmt.Println(f)
}

// $ go run hello-world.go
