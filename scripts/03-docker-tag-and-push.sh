#!/bin/bash
tag=${1:-dev}
buildTag=${2}
echo "$DOCKER_PASS" | docker login --username chips5k --password-stdin
docker tag chips5k/go-api chips5k/go-api:$tag
docker push chips5k/go-api:$tag
if [ $tag != "dev" ]; then
    docker tag chips5k/go-api:$tag chips5k/go-api:latest
    docker tag chips5k/go-api:$tag chips5k/go-api:$buildTag
    docker push chips5k/go-api:latest
    docker push chips5k/go-api:$buildTag
fi  