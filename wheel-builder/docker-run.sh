#! /bin/bash

set -e

echo "Removing 'synth' container"
echo "Ignore 'No such container' errors"
docker rm synth || true

echo "Running 'algocompsynth/synth:latest'"
docker run --interactive --tty \
  --name synth \
  --network host \
  --runtime nvidia \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --env DISPLAY=$DISPLAY \
  algocompsynth/synth:latest /bin/bash
