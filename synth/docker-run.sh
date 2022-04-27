#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
export REPO="synth"

echo "Removing '$REPO' container"
echo "Ignore 'No such container' errors"
docker rm $REPO || true

echo "Getting latest image name"
export IMAGE_NAME=`docker images | grep $REPO | head -n 1 | sed 's/  */:/' | sed 's/ .*$//'`

echo "Running $IMAGE_NAME"
docker run --interactive --tty \
  --name $REPO \
  --network host \
  --runtime nvidia \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --env DISPLAY=$DISPLAY \
  $IMAGE_NAME /bin/bash
