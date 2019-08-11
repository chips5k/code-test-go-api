#!/bin/bash

environment = ${1:-development-go-api}
tag=${2:-dev}

echo "Setting deploy tag to ${tag}"
sed -i.bk -e "s/\${tag}/$tag/" Dockerrun.aws.json

echo "Ensure environment"

eb printenv || eb create ${environment}

echo "Deploy to environment"
eb deploy ${environment}