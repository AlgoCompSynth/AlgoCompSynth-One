#! /bin/bash

set -e

echo "Defining environment variables"
source ../jetpack-envars.sh
export REPO=$SYNTH_REPO
export IMAGE_NAME=$SYNTH_IMAGE

echo "Removing '$REPO' container"
echo "Ignore 'No such container' errors"
docker rm $REPO || true

echo "Running $IMAGE_NAME"
docker run --interactive --tty \
  --name $REPO \
  --network host \
  --runtime nvidia \
  $IMAGE_NAME /bin/bash
