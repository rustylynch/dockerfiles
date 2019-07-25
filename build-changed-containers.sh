#!/bin/bash

declare -A DIRS

# build a list of directories that have code changes
for i in `git diff --name-only HEAD~1`; do
    D=`dirname $i`
    if test -f $D/Dockerfile; then
	DIRS[$D]=1
    fi
done

# Kick off docker builds for any directories
# that contain a docker file
for i in ${!DIRS[@]}; do
    docker build -t clearlinux/$i:latest $i
done
