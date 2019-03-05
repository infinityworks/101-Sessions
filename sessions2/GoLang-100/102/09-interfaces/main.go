package main

import (
	"fmt"
	"time"
)

// define an interface.
type named interface {
	Name() string
}

// define a type product.
type product struct {
	name string
	cost int64
}

// implement the `named` interface
func (p product) Name() string {
	return p.name
}

// define another type which implements the interface.
type person struct {
	name string
	dob  time.Time
}

func (p person) Name() string {
	return p.name
}

func main() {
	john := person{
		name: "John Coltrane",
		dob:  time.Date(1926, time.September, 23, 0, 0, 0, 0, time.UTC),
	}
	printName(john)
	noodles := product{
		name: "noodles",
		cost: 235,
	}
	printName(noodles)
}

func printName(n named) {
	fmt.Println(n.Name())
}
