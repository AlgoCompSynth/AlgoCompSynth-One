#! /bin/bash

set -e

docker run --interactive --tty \
  --name synth \
  --network host \
  --runtime nvidia \
  algocompsynth/synth:latest /bin/bash
