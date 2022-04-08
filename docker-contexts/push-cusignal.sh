#! /bin/bash

set -e

docker login
export SYNTH_RELEASE=0.9.5
docker push "algocompsynth/cusignal:latest"
if [ ${#SYNTH_RELEASE} -gt "0" ]
then 
  docker tag "algocompsynth/cusignal:latest" "algocompsynth/cusignal:$SYNTH_RELEASE"
  docker push "algocompsynth/cusignal:$SYNTH_RELEASE"
fi
