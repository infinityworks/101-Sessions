package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	var wg sync.WaitGroup

	wg.Add(1)
	go func() {
		for i := 0; i < 5; i++ {
			time.Sleep(time.Second)
			fmt.Println("A:", i)
		}
		fmt.Println("A is complete.")
		wg.Done()
	}()

	wg.Add(1)
	go func() {
		for i := 0; i < 20; i++ {
			time.Sleep(time.Millisecond * 500)
			fmt.Println("B:", i)
		}
		fmt.Println("B is complete.")
		wg.Done()
	}()

	wg.Wait()

	fmt.Println("Everything is done, shutting down.")
}
