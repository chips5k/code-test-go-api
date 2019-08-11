package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func performGetRequest(t *testing.T, endpoint string) *httptest.ResponseRecorder {
	a := App{}
	a.Bootstrap()

	req, err := http.NewRequest("GET", endpoint, nil)
	if err != nil {
		t.Fatal(err)
	}
	rr := httptest.NewRecorder()
	handler := http.Handler(a.Router)
	handler.ServeHTTP(rr, req)

	return rr
}
func TestGetDefaultRoute(t *testing.T) {
	
	rr := performGetRequest(t, "/")

	// Check the response status is correct
	if rr.Code != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v expected %v",
			rr.Code, http.StatusOK)
	}

	// Check the response body is correct.
	expected := `<h1>Welcome to the test api</h1>`
	if rr.Body.String() != expected {
		t.Errorf("handler returned unexpected body: got %v expected %v",
			rr.Body.String(), expected)
	}
}


func TestGetHealthRoute(t *testing.T) {
	
	rr := performGetRequest(t, "/health")

	// Check the response status is correct
	if rr.Code != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v expected %v",
			rr.Code, http.StatusOK)
	}

	// Check the response body is correct.
	expected := `{"kicking": true}`
	if rr.Body.String() != expected {
		t.Errorf("handler returned unexpected body: got %v expected %v",
			rr.Body.String(), expected)
	}
}


func TestGetMetaRoute(t *testing.T) {
	
	rr := performGetRequest(t, "/meta")

	var meta = ParseMetaJSON("meta.json");

	// Check the response status is correct
	if rr.Code != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v expected %v",
			rr.Code, http.StatusOK)
	}

	// Check the response body is correct.
	if rr.Body.String() != string(meta) {
		t.Errorf("handler returned unexpected body: got %v expected %v",
			rr.Body.String(), string(meta))
	}
}