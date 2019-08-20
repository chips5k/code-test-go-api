#!/bin/bash
set -euo pipefail
die(){ echo "$1, aborting..."; exit -1; }

[[ ! -v EB_ENVIRONMENT ]] && die 'missing environment variable EB_ENVIRONMENT';

hash eb 2>/dev/null || die 'missing depedency eb (awsebcli)';

environment=$EB_ENVIRONMENT

eb printenv "$environment" && eb terminate "$environment" --force