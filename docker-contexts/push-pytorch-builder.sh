#! /bin/bash

set -e

docker login
export SYNTH_RELEASE=0.9.5
docker push "algocompsynth/pytorch-builder:latest"
if [ ${#SYNTH_RELEASE} -gt "0" ]
then 
  docker tag "algocompsynth/pytorch-builder:latest" "algocompsynth/pytorch-builder:$SYNTH_RELEASE"
  docker push "algocompsynth/pytorch-builder:$SYNTH_RELEASE"
fi
