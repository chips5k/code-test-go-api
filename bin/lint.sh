#!/bin/bash
set -euo pipefail

shellcheck -x ./bin/*.sh

go get golang.org/x/lint/golint

golint ./*.go