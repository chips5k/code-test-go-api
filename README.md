
[![CircleCI](https://circleci.com/gh/chips5k/go-api.svg?style=svg&circle-token=ee0b459f046fcee48289f7e546b3f5f17a20f9b8)](https://circleci.com/gh/chips5k/go-api)

# Setup

Ensure you have go installed and correctly configured: 
- https://golang.org/doc/install
- https://www.ardanlabs.com/blog/2016/05/installing-go-and-your-workspace.html
  
Run the following to install dependencies and build/install the app to your go bin directory

```
go get -d -v ./...
go install -v ./...
```

To run the tests

```
go test
```


If you need to mess around with docker images, or the elastic beanstalk environments, both docker and awsebcli will be required, along with access to dockerhub and aws accounts.

# CI/CD
All commits will trigger the ci/cd pipeline/workflow in circleci. this will automatically lint, build, test, publish and deploy the application to an elastic beanstalk environment (the environment will be created if it not present). 

If you wish to tear the environment down, there is a manual approval step in the workflow to do so.

If you wish to skip running the ci pipeline, include [skip ci] in your commit message.


# Notes
- I've chosen to stick with building, and testing the docker image (since thats what we are going to push all the way), rather than just lint, build, test with go directly.
- assume developers can run required tools locally (e.g they wont use docker for development purposes)
- assume developers wont be pushing anything manually

# Improvements
- setup dedicated docker image that contains go, golint, shellcheck, awsebcli, docker and use this for each build step to avoid the need to install dependencies, cluttering up scripts and pipeline config.
- if the above was put in place, scripts could be updated to fail on missing deps