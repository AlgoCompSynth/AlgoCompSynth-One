#! /bin/bash

set -e

docker login
export SYNTH_RELEASE=0.9.5
docker push "algocompsynth/synth:latest"
if [ ${#SYNTH_RELEASE} -gt "0" ]
then 
  docker tag "algocompsynth/synth:latest" "algocompsynth/synth:$SYNTH_RELEASE"
  docker push "algocompsynth/synth:$SYNTH_RELEASE"
fi
