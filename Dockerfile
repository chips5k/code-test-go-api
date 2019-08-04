FROM golang:1.8

WORKDIR /go/src/app
COPY main.go main_test.go ./

RUN go get -d -v ./...
RUN go install -v ./...

EXPOSE 5000

ENTRYPOINT ["app"]