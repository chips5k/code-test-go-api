#!/bin/bash
set -euo pipefail
die(){ echo "$1, aborting..."; exit -1; }

hash shellcheck 2>/dev/null || die 'missing depedency shellcheck';
hash golint 2>/dev/null || die 'missing depedency golint';

shellcheck -x ./bin/*.sh
golint ./*.go