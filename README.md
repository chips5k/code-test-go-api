
[![CircleCI](https://circleci.com/gh/chips5k/go-api.svg?style=svg&circle-token=ee0b459f046fcee48289f7e546b3f5f17a20f9b8)](https://circleci.com/gh/chips5k/go-api)

# Setup

# Notes
- I've chosen to stick with building, and testing the docker image (since thats what we are going to push all the way), rather than just lint, build, test with go directly.
- assume developers can run required tools locally (e.g they wont use docker for development purposes)
- assume developers wont be pushing anything manually

# Improvements
- setup dedicated docker image that contains go, golint, shellcheck, awsebcli, docker and use this for each build step to avoid the need to install dependencies, cluttering up scripts and pipeline config.
- if the above was put in place, scripts could be updated to fail on missing deps