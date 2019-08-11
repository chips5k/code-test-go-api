#!/bin/bash
environment=${1:-"development-go-api"}
eb printenv $environment && eb terminate $environment