package main

import (
	"fmt"
	"net/http"
)

// Demonstrates the use of a pointer receiver.

// Handler implements the http.Hanler interface by having a ServeHTTP method.
type Handler struct {
	count int
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	h.count++
	w.Write([]byte(fmt.Sprintf("%d", h.count)))
}

func main() {
	h := &Handler{}
	http.Handle("/", h)
	http.ListenAndServe(":8000", nil)
}
