#!/bin/bash
set -euo pipefail
die(){ echo "$1, aborting..."; exit -1; }

[[ ! -v CIRCLE_WORKFLOW_ID ]] && die 'missing environment variable CIRCLE_WORKFLOW_ID';
[[ ! -v CIRCLE_SHA1 ]] && die 'missing environment variable CIRCLE_SHA1';
[[ ! -v DOCKER_PASS ]] && die 'missing environment variable DOCKER_PASS';

hash docker 2>/dev/null || die 'missing depedency docker';

sha=$CIRCLE_SHA1
workflowID=$CIRCLE_WORKFLOW_ID

echo "$DOCKER_PASS" | docker login --username chips5k --password-stdin

docker pull "chips5k/go-api:$sha"

docker tag "chips5k/go-api:$sha" "chips5k/go-api:$workflowID"
docker tag "chips5k/go-api:$sha"  "chips5k/go-api:latest"

docker push "chips5k/go-api:$workflowID"
docker push "chips5k/go-api:latest"
