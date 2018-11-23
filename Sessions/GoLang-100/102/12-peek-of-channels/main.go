package main

import (
	"fmt"
	"math/rand"
	"time"
)

func fanout(input chan int, outputs ...chan int) {
	for v := range input {
		for _, o := range outputs {
			o <- v
		}
	}
	for _, o := range outputs {
		close(o)
	}
}

func main() {
	messages := make(chan int)

	go func() {
		for i := 0; i < 10; i++ {
			messages <- rand.Intn(10)
		}
		close(messages)
	}()

	receiverA := make(chan int, 10)
	receiverB := make(chan int, 10)

	aComplete := make(chan bool)
	bComplete := make(chan bool)

	go func() {
		for n := range receiverA {
			fmt.Printf("receiver A: %d\n", n)
		}
		aComplete <- true
	}()
	go func() {
		for n := range receiverB {
			time.Sleep(time.Second)
			fmt.Printf("receiver B: %d\n", n)
		}
		bComplete <- true
	}()

	fanout(messages, receiverA, receiverB)

	// Let's timeout after 3 seconds.
	<-aComplete
	<-bComplete
	fmt.Println("Everything is finished")
}
