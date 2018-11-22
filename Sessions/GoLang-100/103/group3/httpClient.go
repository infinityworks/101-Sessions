// package group3

package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
)

func main() {
	r := Client("ChesterGate")
	fmt.Println(r)
}

func Client(s string) ApiResponse {
	client := &http.Client{Timeout: time.Second * 10}

	req, err := http.NewRequest("GET", "http://api.ratings.food.gov.uk/Establishments/?name="+s, nil)
	if err != nil {
		// handle error
	}
	req.Header.Add("x-api-version", "2")

	resp, err := client.Do(req)
	if err != nil {
		// handle error
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)

	if err != nil {
		// handle error
	}

	var r ApiResponse
	str := body
	json.Unmarshal([]byte(str), &r)
	return r

}

type ApiResponse struct {
	Establishments []struct {
		FHRSID                   int    `json:"FHRSID"`
		LocalAuthorityBusinessID string `json:"LocalAuthorityBusinessID"`
		BusinessName             string `json:"BusinessName"`
		SchemeType               string `json:"SchemeType"`
	} `json:"establishments"`
}

// https://mholt.github.io/json-to-go/
