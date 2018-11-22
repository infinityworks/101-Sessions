package main

// package group1

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
)

func main() {
	Server()
}

func Server() {
	http.HandleFunc("/search", search)
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
func search(w http.ResponseWriter, r *http.Request) {
	fmt.Println("method:", r.Method)
	if r.Method == "GET" {
		t, _ := template.ParseFiles("form.html")
		t.Execute(w, nil)
	} else {
		r.ParseForm()
		fmt.Fprintf(w, r.FormValue("searchTerm")) // write data to response
	}
}
