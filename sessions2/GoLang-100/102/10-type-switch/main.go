package main

import (
	"fmt"
	"time"
)

type product struct {
	name string
	cost int64
}

type person struct {
	name string
	dob  time.Time
}

func main() {
	john := person{
		name: "John Coltrane",
		dob:  time.Date(1926, time.September, 23, 0, 0, 0, 0, time.UTC),
	}
	print(john)
	noodles := product{
		name: "noodles",
		cost: 235,
	}
	print(noodles)
	print("a string?")
}

func print(v interface{}) {
	switch v := v.(type) {
	case person:
		fmt.Println("Person birthday:", v.dob)
		break
	case product:
		fmt.Println("Product cost:", v.cost)
		break
	default:
		fmt.Println("Unknown type.")
	}
}
