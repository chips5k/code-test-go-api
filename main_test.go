package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestEndpoint(t *testing.T) {
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		t.Fatal(err)
	}
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(handler)
	handler.ServeHTTP(rr, req)

	// Check the response status is correct
	if rr.Code != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v expected %v",
			rr.Code, http.StatusOK)
	}

	// Check the response body is correct.
	expected := `Hello World1!`
	if rr.Body.String() != expected {
		t.Errorf("handler returned unexpected body: got %v expected %v",
			rr.Body.String(), expected)
	}
}