#!/bin/bash
case $1 in
     "start")      
          go get -d -v ./...
          go install -v ./...
          go-api
          ;;
     "start-watch")      
          go get -d -v ./...
          go install -v ./...
          go install github.com/canthefason/go-watcher/cmd/watcher
          watcher
          ;;
     "test")      
          go get -d -v ./...
          go install -v ./...
          go test -v ./...
          ;;
     "run-docker")
          ./scripts/01-docker-build.sh
          docker run  --rm -p 5000:5000 chips5k/go-api
          ;; 
     "test-docker")
          ./scripts/01-docker-build.sh
          ./scripts/02-docker-test.sh
          ;;
    "deploy-dev")
          ./scripts/01-docker-build.sh
          ./scripts/02-docker-test.sh
          ./scripts/03-docker-tag-and-push.sh
          ./scripts/04-deploy.sh
          ;;
    "teardown-dev")
          ./scripts/05-teardown.sh
          ;;
     *)
         echo "Enter a task name: start, start-watch, test, run-docker, test-docker, deploy-dev, teardown-dev"
          ;;

esac
