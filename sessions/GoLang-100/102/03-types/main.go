package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"
)

// Demonstrates the use of a custom struct to output JSON.

type user struct {
	Name     string    `json:"name"`
	Birthday time.Time `json:"dob"`
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		u := user{
			Name:     "John Coltrane",
			Birthday: time.Date(1926, time.September, 23, 0, 0, 0, 0, time.UTC),
		}
		d, err := json.Marshal(u)
		if err != nil {
			log.Printf("failed to marshal JSON: %v", err)
			http.Error(w, "failed to marshal JSON", http.StatusInternalServerError)
		}
		w.Write(d)
	})
	// nil means that the server serves the default "mux" (routes).
	http.ListenAndServe(":8000", nil)
}
