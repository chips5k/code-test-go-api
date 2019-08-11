
[![CircleCI](https://circleci.com/gh/chips5k/go-api.svg?style=svg&circle-token=ee0b459f046fcee48289f7e546b3f5f17a20f9b8)](https://circleci.com/gh/chips5k/go-api)


# Setup

1. Ensure you have the following installed and configured:
    - Docker
    - Golang

2. run ./dev-tasks.sh to be presented with a list of available tasks
3. run ./dev-tasks.sh start-watch to rebuild, rerun as files are changed

2. Setup for dev environment deployments (optional)
2. Request access to the chips5k/go-api dockerhub repository in order to push images (for dev purposes)
3. Either provide AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as environment variables, or modify .elasticbeanstalk/config.yml to include a `profile: eb-cli` under the `global` section.


2. run ./dev-tasks.sh to be presented with a list of available tasks.

3. Deploying to development environment
If you wish to deploy to an elasticbeanstalk dev environment, you will need to either  run the ./dev-tasks.sh deploy-dev and teardown-dev tasks.


# Developing
 
 run ./dev-tasks.sh for a list of available tasks

# Deploying from command line

if desired, you can perform dev environment deployments from the command line.
Ensure you have the elastic beanstalk cli installed to do this: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html

As the circleci pipelines provide aws access tokens and secrets via env vars, the elasticbeanstalk config is not set to rely on eb-cli auth.
You can either include AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as env vars or add `profile: eb-cli` to the bottom of .elastic-beanstalk/config.yml global section.

Once setup, run ./dev-tasks.sh deploy-dev or teardown-dev


# Overview
- .circleci contains ci/cid pipeline workflows/jobs configuration
- .ebextension, .elasticbeanstalk and Dockerrun.aws.json required config files for aws eb setup.
- scripts folder contains scripts primarily used by the ci/cd pipelines, however these accept params so they can be utilized locally via dev-tasks.sh.

## Current ci/cd, deployment config
- build/test will only be run when a branch with an open PR is present
- build/test/tag/deploy only runs on master branch and has required manual approval to deploy and tear down.
- if production environment is not present, the scripts will automatically set one up and deploy to it (note this also applys with running local dev deploy)





