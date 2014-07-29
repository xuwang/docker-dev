#!/bin/bash
set -e

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

. $SCRIPT_HOME/env.sh

for dir in $SCRIPT_HOME/../images/*/
do
	cd $dir &&
	image_name=${PWD##*/} && # i.e. $(basename $PWD)
	echo "Pushing $image_name to $DOCKER_REPO" &&
	docker push $DOCKER_REPO/$image_name
done
