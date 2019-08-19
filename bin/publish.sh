#!/bin/bash
sha=$CIRCLE_SHA1
workflowID=$CIRCLE_WORKFLOW_ID
echo "$DOCKER_PASS" | docker login --username chips5k --password-stdin
docker tag "chips5k/go-api:$sha" "chips5k/go-api:$workflowID"
docker tag "chips5k/go-api:$sha"  "chips5k/go-api:latest"
docker push "chips5k/go-api:$workflowID"
docker push "chips5k/go-api:latest"
