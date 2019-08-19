#!/bin/bash

set -euo pipefail

environment="production-go-api"

eb printenv $environment && eb terminate $environment --force