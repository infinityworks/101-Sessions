package logic

import (
	"fmt"
	"sort"
	"strings"
	"sync"
	"time"
)

type Counter interface {
	CountEstablishments(s string) (count int, err error)
}
type EstablishmentCounter struct {
	Counter Counter
}

func (ec EstablishmentCounter) ParseString(s string) (counts []int, err error) {
	var wg sync.WaitGroup
	parts := strings.Split(s, ",")
	c := make(chan int, len(parts))
	for _, shop := range parts {
		wg.Add(1)
		go func(s string) {
			defer wg.Done()
			start := time.Now()
			count, err := ec.Counter.CountEstablishments(s)
			fmt.Printf("Duration: %d ms\n", time.Now().Sub(start)/time.Millisecond)
			if err != nil {
				//TODO: Log or do _something_.
				return
			}
			c <- count
		}(shop)
	}
	fmt.Println("Waiting for everything to close.")
	wg.Wait()
	close(c)
	for v := range c {
		counts = append(counts, v)
	}
	sort.Ints(counts)
	return
}
