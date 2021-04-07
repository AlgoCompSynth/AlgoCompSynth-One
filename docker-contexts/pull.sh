#! /bin/bash

set -e

echo "pulling AlgoCompSynth images"
for image in \
  nvcr.io/nvidia/l4t-base:r32.5.0 \
  docker.io/algocompsynth/algocompsynth-1 \
  docker.io/algocompsynth/algocompsynth-1r
do
  sudo docker pull "$image"
done
