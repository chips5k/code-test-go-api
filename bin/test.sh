#!/bin/bash
set -euo pipefail
die(){ echo "$1, aborting..."; exit -1; }

[[ ! -v CIRCLE_SHA1 ]] && die 'missing environment variable CIRCLE_SHA1';
[[ ! -v DOCKER_PASS ]] && die 'missing environment variable DOCKER_PASS';

hash docker 2>/dev/null || die 'missing depedency docker';

sha=$CIRCLE_SHA1
echo "$DOCKER_PASS" | docker login --username chips5k --password-stdin
docker run --entrypoint go "chips5k/go-api:$sha" test