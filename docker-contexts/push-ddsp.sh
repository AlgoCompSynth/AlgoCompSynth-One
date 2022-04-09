#! /bin/bash

set -e

docker login
export SYNTH_RELEASE=0.9.5
docker push "algocompsynth/ddsp:latest"
if [ ${#SYNTH_RELEASE} -gt "0" ]
then 
  docker tag "algocompsynth/ddsp:latest" "algocompsynth/ddsp:$SYNTH_RELEASE"
  docker push "algocompsynth/ddsp:$SYNTH_RELEASE"
fi
