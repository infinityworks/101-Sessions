package main

// package group2

import (
	"fmt"
	"strings"
)

func main() {
	s := "test,sss,ttt"
	r := Engine(s)
	fmt.Println(r)
}

func Engine(s string) []int {

	requestVals := strings.Split(s, ",")
	ch := make(chan int)

	for _, v := range requestVals {
		go makeRequest(v, ch)
	}

	a := make([]int, len(requestVals))

	for i := 0; i < len(requestVals); i++ {
		a[i] = <-ch
	}

	return a
}

func makeRequest(s string, ch chan<- int) {

	ch <- len(s)
}
