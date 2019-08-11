#!/bin/bash
environment=${1:-"development-go-api"}
eb printenv && eb terminate $environment