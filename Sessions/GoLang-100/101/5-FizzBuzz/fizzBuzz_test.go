package main

import "testing"

func TestFizzBuzz(t *testing.T) {
	output := fizzBuzz(0)

	if output != 0 {
		t.Errorf("FizzBuzz was incorrect, got: %d, want: %d.", output, 0)
	}
}
