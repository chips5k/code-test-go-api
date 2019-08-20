#!/bin/bash
set -euo pipefail
die(){ echo "$1, aborting..."; exit -1; }

[[ ! -v CIRCLE_WORKFLOW_ID ]] && die 'missing environment variable CIRCLE_WORKFLOW_ID';
[[ ! -v EB_ENVIRONMENT ]] && die 'missing environment variable EB_ENVIRONMENT';

hash eb 2>/dev/null || die 'missing depedency eb (awsebcli)';

environment=$EB_ENVIRONMENT
workflowID=$CIRCLE_WORKFLOW_ID
tag=$workflowID

echo "Setting deploy tag to $tag"
sed -i.bk -e "s@\${tag}@${tag}@" Dockerrun.aws.json
echo "Ensure environment"
eb printenv $environment || eb create $environment

echo "Deploy to environment"
eb deploy $environment