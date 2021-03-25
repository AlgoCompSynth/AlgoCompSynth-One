#! /bin/bash

set -e

echo "pulling AlgoCompSynth images"
for image in \
  internal-ubuntu-builder \
  synth
do
  sudo docker pull "synth/$image:latest"
done

echo "Pulling L4T images"
for image in \
  nvcr.io/nvidia/l4t-base:r32.5.0 \
  nvcr.io/nvidia/l4t-base:r32.4.4 \
  nvcr.io/nvidia/l4t-ml:r32.5.0-py3 \
  nvcr.io/nvidia/l4t-ml:r32.4.4-py3
do
  sudo docker pull "$image"
done
