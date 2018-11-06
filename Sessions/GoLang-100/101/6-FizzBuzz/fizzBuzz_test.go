package main

import (
	"strconv"
	"testing"
)

var buzzTests = []struct {
	in  int
	out string
}{
	{0, "0"},
	{1, "1"},
	{2, "2"},
	{3, "Fizz"},
	{4, "4"},
	{5, "Buzz"},
	{6, "Fizz"},
	{7, "7"},
	{8, "8"},
	{9, "Fizz"},
	{10, "Buzz"},
	{11, "11"},
	{12, "Fizz"},
	{13, "13"},
	{14, "14"},
	{15, "FizzBuzz"},
	{16, "16"},
}

func TestFizzBuzz(t *testing.T) {
	for _, tt := range buzzTests {
		t.Run(strconv.Itoa(tt.in), func(t *testing.T) {
			s := fizzBuzz(tt.in)
			if s != tt.out {
				t.Errorf("FizzBuzz was incorrect, got: %s, want: %s.", s, tt.out)
			}
		})
	}
}
