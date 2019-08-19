#!/bin/bash
environment="production-go-api"
eb printenv $environment && eb terminate $environment --force