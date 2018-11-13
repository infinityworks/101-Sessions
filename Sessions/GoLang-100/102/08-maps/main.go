package main

import (
	"fmt"
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

	// We can preinitialize the map's size with:
	// make(map[string]int64, len(products))
	nameToCost := make(map[string]int64, len(products))
	for _, p := range products {
		nameToCost[p.name] = p.cost
	}

	// Search the map.
	itemsToLookup := []string{"panang", "chow mein"}
	for _, itm := range itemsToLookup {
		cost, exists := nameToCost[itm]
		if exists {
			fmt.Printf("%s: %d\n", itm, cost)
		} else {
			fmt.Printf("%s is not available\n", itm)
		}
	}

	// Iterate through keys and values.
	// Note that the order is random.
	fmt.Println()
	fmt.Println("All values")
	for name, cost := range nameToCost {
		fmt.Printf("Name: %v, Cost: %v\n", name, cost)
	}
}
