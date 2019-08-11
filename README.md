
[![CircleCI](https://circleci.com/gh/chips5k/go-api.svg?style=svg&circle-token=ee0b459f046fcee48289f7e546b3f5f17a20f9b8)](https://circleci.com/gh/chips5k/go-api)


# Developer setup
1. Ensure you have the following installed and configured:
    - Docker
    - Golang
    - eb-cli (optional) https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html

2. (Optional) If you wish to perform dev eb deployments from your local machine:
   1. Request access to the `chips5k/go-api` dockerhub repository in order to push images (for dev purposes)
   2. Login to docker from the command line
   3. Either provide `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as environment variables, or modify `.elasticbeanstalk/config.yml` to include a `profile: eb-cli` under the `global` section.
3. run `./dev-tasks.sh` to be presented with a list of available tasks
   1. **Local go commands**
      1. run `./dev-tasks.sh start` to build and run the app
      2. run `./dev-tasks.sh start-watch` to rebuild, rerun as files are changed
      3. run `./dev-tasks.sh test` to run the tests
   2. **Docker commands:**
      1. run `./dev-tasks.sh run-docker` to run the application inside docker
      2. run `./dev-tasks.sh test-docker` to run the app tests inside docker
   3. **Elasticbeanstalk commands**
      1. run `./dev-tasks.sh deploy-dev` to deploy to the dev eb env
      2. run `./dev-tasks.sh teardown-dev` to remove the dev environment

# Deploying to production

# CI/CD, Environments, Automation etc...

# Improvements, Explanations, reasons...









