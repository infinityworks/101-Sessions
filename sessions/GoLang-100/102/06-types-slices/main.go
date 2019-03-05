package main

import (
	"encoding/json"
	"net/http"
	"strconv"
)

// Demonstrates the use of a pointer receiver.

// Handler implements the http.Hanler interface by having a ServeHTTP method.
type Handler struct {
	users []user
}

type user struct {
	Name string `json:"name"`
}

func (h Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	takeParam := r.URL.Query().Get("take")
	take, err := strconv.ParseInt(takeParam, 10, 64)
	if err != nil {
		http.Error(w, "invalid take querystring parameter, should be a number", http.StatusBadRequest)
		return
	}
	// Take a slice of the data.
	if int(take) > len(h.users) {
		take = int64(len(h.users))
	}
	users := h.users[:take]
	// You can do other fancy stuff with slice ranges.
	// e.g. users[1:3]
	// or users[:] to copy a slice.
	d, err := json.Marshal(users)
	if err != nil {
		http.Error(w, "failed to marshal users", http.StatusBadRequest)
	}
	w.Write(d)
}

func main() {
	users := []user{
		user{
			Name: "A",
		},
		user{
			Name: "B",
		},
		user{
			Name: "C",
		},
		user{
			Name: "D",
		},
		user{
			Name: "E",
		},
		user{
			Name: "F",
		},
	}
	h := Handler{
		users: users,
	}
	http.Handle("/", h)
	http.ListenAndServe(":8000", nil)
}
