#! /bin/bash

set -e

echo "Running 'algocompsynth/synth:latest'"
docker run --interactive --tty \
  --name synth \
  --network host \
  --runtime nvidia \
  algocompsynth/synth:latest /bin/bash
