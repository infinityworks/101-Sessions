package main

import "net/http"

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello!"))
	})
	// nil means that the server serves the default "mux" (routes).
	http.ListenAndServe(":8000", nil)
}
