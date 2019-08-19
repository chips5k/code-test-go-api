#!/bin/bash
shellcheck ./bin/*.sh
go get golang.org/x/lint/golint
golint ./*.go