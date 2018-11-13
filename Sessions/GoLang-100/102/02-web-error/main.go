package main

import (
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

// Demonstrates how functions can have multiple return types.
// Note how the err (error) parameter comes last.

// Try deleting the input.txt file to see the errors.

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		f, err := os.Open("input.txt")
		if err != nil {
			log.Printf("failed to open file: %v", err)
			http.Error(w, "failed to open", http.StatusInternalServerError)
			return
		}
		content, err := ioutil.ReadAll(f)
		if err != nil {
			log.Printf("failed to read file: %v", err)
			http.Error(w, "failed to read", http.StatusInternalServerError)
			return
		}
		w.Write(content)
	})
	// nil means that the server serves the default "mux" (routes).
	http.ListenAndServe(":8000", nil)
}
