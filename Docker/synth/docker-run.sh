#! /bin/bash

set -e

echo "Defining environment variables"
source ../jetpack-envars.sh
export REPO=$SYNTH_REPO
export IMAGE_NAME=$SYNTH_IMAGE

echo "Removing '$REPO' container"
echo "Ignore 'No such container' errors"
docker rm $REPO || true

docker pull $IMAGE_NAME

echo "Running $IMAGE_NAME"
docker run --interactive --tty \
  --name $REPO \
  --network host \
  --runtime nvidia \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --env DISPLAY=$DISPLAY \
  $IMAGE_NAME /bin/bash
