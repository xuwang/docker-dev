#!/bin/bash
set -e

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

. $SCRIPT_HOME/env.sh

image_name=$DOCKER_REPO/${PWD##*/} && # i.e. $(basename $PWD)
echo "Building $image_name" &&
docker build -t $image_name .