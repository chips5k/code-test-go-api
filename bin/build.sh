#!/bin/bash
set -euo pipefail
die(){ echo "$1, aborting..."; exit -1; }

[[ ! -v CIRCLE_SHA1 ]] && die 'missing environment variable CIRCLE_SHA1';
[[ ! -v CIRCLE_BRANCH ]] && die 'missing environment variable CIRCLE_BRANCH';
[[ ! -v CIRCLE_BUILD_NUM ]] && die 'missing environment variable CIRCLE_BUILD_NUM';
[[ ! -v CIRCLE_WORKFLOW_ID ]] && die 'missing environment variable CIRCLE_WORKFLOW_ID';
[[ ! -v DOCKER_PASS ]] && die 'missing environment variable DOCKER_PASS';

hash docker 2>/dev/null || die 'missing depedency eb (awsebcli)';
hash sed 2>/dev/null || die 'missing depedency sed';

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
docker push "chips5k/go-api:$sha"