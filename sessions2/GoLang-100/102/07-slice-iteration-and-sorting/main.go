package main

import (
	"fmt"
	"sort"
)

type product struct {
	name string
	cost int64
}

func main() {
	products := []product{
		product{
			name: "green curry",
			cost: 460,
		},
		product{
			name: "noodles",
			cost: 50,
		},
		product{
			name: "rice",
			cost: 30,
		},
		product{
			name: "panang",
			cost: 300,
		},
	}

	// A range loop returns both the index and the item in one operation.
	for index, p := range products {
		fmt.Printf("%d: %s\n", index, p.name)
	}

	// Lets sort the items by their cost ascending.
	byCostAscending := func(i, j int) bool {
		return products[i].cost < products[j].cost
	}
	sort.Slice(products, byCostAscending)

	fmt.Println()
	fmt.Println("By prices ascending")
	for index, p := range products {
		fmt.Printf("%d: %s - %d\n", index, p.name, p.cost)
	}
}
