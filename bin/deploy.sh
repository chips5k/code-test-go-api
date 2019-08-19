#!/bin/bash

set -euo pipefail

environment="production-go-api"
workflowID=$CIRCLE_WORKFLOW_ID
tag="chips5k/go-api:$CIRCLE_WORKFLOW_ID"

echo "Setting deploy tag to $tag"
sed -i.bk -e "s@\${tag}@${tag}@" Dockerrun.aws.json
echo "Ensure environment"
eb printenv $environment || eb create $environment

echo "Deploy to environment"
eb deploy $environment