package main

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"io"
	"io/ioutil"
	"log"
	"net/http"
)

//App ... the app container
type App struct {
	Router *mux.Router
}

//Meta ... details about the application build
type Meta struct {
	CommitSha       string
	Branch          string
	BuildNumber     string
	BuildWorkflowID string
	BuildDateTime   string
	DockerHubImage  string
}

//LoggingMiddleware ... simple logging
func LoggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Request received: %s", r.RequestURI)
		next.ServeHTTP(w, r)
	})
}

//HealthCheckRouteHandler ... responds with a 200 ok if alive and kicking
func HealthCheckRouteHandler(w http.ResponseWriter, r *http.Request) {

	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	w.Write([]byte(`{"kicking": true}`))
}

//ParseMetaJSON ... retrieve meta data from file and parse into struct
func ParseMetaJSON(filePath string) []byte {
	var meta Meta

	file, err := ioutil.ReadFile(filePath)

	if err != nil {
		panic(err)
	}

	metaJSON := string(file)

	json.Unmarshal([]byte(metaJSON), &meta)

	result, err := json.Marshal(meta)

	if err != nil {
		panic(err)
	}

	return result
}

//MetaRouteHandler ... responds with meta data about the app
func MetaRouteHandler(w http.ResponseWriter, r *http.Request) {

	var meta = ParseMetaJSON("./meta.json")

	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	w.Write(meta)
}

//DefaultRouteHandler ... responds to requests on the default endpoint
func DefaultRouteHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	io.WriteString(w, `<h1>Welcome to the test api</h1>`)
}

//Bootstrap ... Bootstraps the app with middleware, routing etc...
func (a *App) Bootstrap() {
	a.Router = mux.NewRouter()
	a.Router.Use(LoggingMiddleware)
	a.Router.HandleFunc("/", DefaultRouteHandler).Methods("GET")
	a.Router.HandleFunc("/health", HealthCheckRouteHandler).Methods("GET")
	a.Router.HandleFunc("/meta", MetaRouteHandler).Methods("GET")
}

//Start ... Launches the app on the provided address and port
func (a *App) Start(address string) {
	log.Printf("Launching app on %s", address)
	log.Printf("Listening for requests...")
	log.Fatal(http.ListenAndServe(address, a.Router))
}

func main() {
	a := App{}
	a.Bootstrap()
	a.Start(":5000")
}
