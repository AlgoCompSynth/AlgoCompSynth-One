#! /bin/bash

set -e

docker login
export PYTORCH_VERSION="torch-1.7.1-cp39-cp39-linux_aarch64"
docker push "algocompsynth/pytorch-builder:latest"
if [ ${#PYTORCH_VERSION} -gt "0" ]
then 
  docker tag "algocompsynth/pytorch-builder:latest" "algocompsynth/pytorch-builder:$PYTORCH_VERSION"
  docker push "algocompsynth/pytorch-builder:$PYTORCH_VERSION"
fi
