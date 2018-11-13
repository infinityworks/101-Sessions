package main

import (
	"fmt"
	"time"
)

func main() {
	messagesFromA := make(chan string)
	messagesFromB := make(chan string)

	go func() {
		for i := 0; i < 5; i++ {
			time.Sleep(time.Second)
			messagesFromA <- fmt.Sprintf("A: %d", i)
		}
	}()

	go func() {
		for i := 0; i < 20; i++ {
			time.Sleep(time.Millisecond * 500)
			messagesFromB <- fmt.Sprintf("B: %d", i)
		}
	}()

	// Let's timeout after 3 seconds.
	timeout := time.After(time.Second * 3)

	// A channel switch will receive from the channels.
out:
	for {
		select {
		case fromA := <-messagesFromA:
			fmt.Println(fromA)
		case fromB := <-messagesFromB:
			fmt.Println(fromB)
		case <-timeout:
			fmt.Println("Timeout reached!")
			break out
		}
	}

	fmt.Println("Everything is done, shutting down.")
}
