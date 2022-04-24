#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
export REPO="wheel-builder"

echo "Removing '$REPO' container"
echo "Ignore 'No such container' errors"
docker rm $REPO || true

echo "Running '$REGISTRY/$ACCOUNT/$REPO:latest'"
docker run --interactive --tty \
  --name $REPO \
  --network host \
  --runtime nvidia \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --env DISPLAY=$DISPLAY \
  $REGISTRY/$ACCOUNT/$REPO:latest /bin/bash
