#!/bin/bash
set -e

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

. $SCRIPT_HOME/env.sh

# the java base for zookeeper and kafka
cd $SCRIPT_HOME/../images/openjdk7-jre/
echo "Building openjdk7-jre from $dir" &&
docker build -t $DOCKER_REPO/openjdk7-jre .

for dir in $SCRIPT_HOME/../images/*/
do
	cd $dir &&
	image_name=${PWD##*/} && # i.e. $(basename $PWD)
	echo "Building $image_name from $dir" &&
	docker build -t $DOCKER_REPO/$image_name .
done
