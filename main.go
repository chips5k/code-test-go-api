package main

import (
	"fmt"
	"encoding/json"
	"net/http"
	"log"
	"github.com/gorilla/mux"
)

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // Do stuff here
        log.Println(r.RequestURI)
        // Call the next handler, which can be another middleware in the chain, or the final handler.
        next.ServeHTTP(w, r)
    })
}

func HealthCheckRouteHandler(w http.ResponseWriter, r *http.Request) {
    
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    io.WriteString(w, `{"alive": true}`)
}

func MetaRouteHandler(w http.ResponseWriter, r *http.Request) {
    
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    io.WriteString(w, `{"alive": true}`)
}

func DefaultRouteHandler(w http.ResponseWriter, r *http.Request) {
    
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    io.WriteString(w, `{"alive": true}`)
}

type App struct {
	Router *mux.Router
}

func (a *App) Initialize() {
	a.Router := mux.NewRouter()
	a.Router.Use(loggingMiddleware)
	a.Router.HandleFunc("/", DefaultRouteHandler).Methods("GET")
	a.Router.HandleFunc("/health", HealthCheckRouteHandler).Methods("GET")
	a.Router.HandleFunc("/meta", MetaRouteHandler).Methods("GET")
}

func (a *App) Start(address string) { 
	log.Fatal(http.ListenAndServe(address, a.Router))
}

func main() {
	a := App{}
	a.Bootstrap()
	a.Start(":5000");
}
