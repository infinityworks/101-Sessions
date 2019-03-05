// This will have to be in your go path

package main

import (
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/poolieweb/fsaweb/fsa"

	"github.com/poolieweb/fsaweb/logic"
)

type requestDurationLogger struct {
	next http.Handler
}

func (rdl requestDurationLogger) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	rdl.next.ServeHTTP(w, r)
	fmt.Printf("%s %s - %dms\n", r.Method, r.URL.String(), time.Now().Sub(start)/time.Millisecond)
}

type countHandler struct {
	counter logic.EstablishmentCounter
	next    http.Handler
}

func (ch countHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		ch.next.ServeHTTP(w, r)
	case http.MethodPost:
		fmt.Println("Received POST")
		err := r.ParseForm()
		if err != nil {
			fmt.Printf("error parsing form: %v", err)
			http.Error(w, "failed to parse form", http.StatusBadRequest)
			return
		}
		ratings, err := ch.counter.ParseString(r.FormValue("blah"))
		if err != nil {
			http.Error(w, "failed to parse string", http.StatusBadRequest)
			return
		}
		s := ""
		for _, r := range ratings {
			s += strconv.Itoa(r) + ","
		}
		fmt.Println("Writing out some bytes.")
		w.Write([]byte(s))
	default:
	}
}

func main() {
	client := fsa.New()
	counter := logic.EstablishmentCounter{
		Counter: client,
	}

	fs := http.FileServer(http.Dir("./"))

	countHandler := countHandler{
		counter: counter,
		next:    fs,
	}
	durationLoggedHandler := requestDurationLogger{
		next: countHandler,
	}

	http.Handle("/", durationLoggedHandler)
	http.ListenAndServe(":8000", nil)
	fmt.Println("Listening on port 8000")
}
