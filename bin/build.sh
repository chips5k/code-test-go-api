#!/bin/bash

sha=$CIRCLE_SHA1
branch=$CIRCLE_BRANCH
number=$CIRCLE_BUILD_NUM
workflow=$CIRCLE_WORKFLOW_ID

image=go-api:$branch:$sha

datetime=$(date '+%Y-%m-%d %H:%M:%S %Z %z')

sed -i.bk \
-e "s/\${sha}/$sha/;" \
-e "s/\${branch}/$branch/;" \
-e "s/\${number}/$number/;" \
-e "s/\${workflow}/$workflow/;" \
-e "s/\${image}/$image/;" \
-e "s/\${datetime}/$datetime/" \
meta.json

docker build -t "chips5k/go-api" -t "chips5k/go-api:$sha" .
echo "$DOCKER_PASS" | docker login --username chips5k --password-stdin
docker push