#!/bin/bash
set -e

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

. $SCRIPT_HOME/env.sh

for dir in $SCRIPT_HOME/../images/*/
do
	cd $dir &&
	image_name=${PWD##*/} && # i.e. $(basename $PWD)
	echo "Building $image_name from $dir" &&
	docker build -t $DOCKER_REPO/$image_name .
done
