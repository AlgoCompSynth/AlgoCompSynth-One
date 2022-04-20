#! /bin/bash

set -e

echo "Removing 'ddsp' container"
echo "Ignore 'No such container' errors"
docker rm ddsp || true

echo "Running 'algocompsynth/ddsp:latest'"
docker run --interactive --tty \
  --name ddsp \
  --network host \
  --runtime nvidia \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --env DISPLAY=$DISPLAY \
  algocompsynth/ddsp:latest /bin/bash
