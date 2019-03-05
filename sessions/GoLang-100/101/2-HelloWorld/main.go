package main

import "fmt"

func main() {
	// Value types
	fmt.Println("Hello " + "101")
	fmt.Println("7.0/3.0 =", 7.0/3.0)
	fmt.Println("7.0/3.0 =", 7.0/3.0, 99)
	fmt.Println("7.0/3.0 =", 7.0/3.0, 99, 123, "321")

	fmt.Println(true || false)

	// Ignore this for now we cover types and assignment later, this called a slice ints with two values, a slice is a reference type
	items := []int{10, 20}

	//Tip "fmt.Println" != "println", Fmt.Println displays the elements, but "println" displays a reference value.
	fmt.Println(items)
	println(items)
}

// $ go run hello-world.go
