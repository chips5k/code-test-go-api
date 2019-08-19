#/bin/bash
sha=$CIRCLE_SHA1
echo "$DOCKER_PASS" | docker login --username chips5k --password-stdin
docker run --entrypoint go "chips5k/go-api:$sha" test