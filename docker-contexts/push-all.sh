#! /bin/bash

set -e

sudo docker login
export SYNTH_RELEASE=0.7.4.9999
for image in \
  docker.io/algocompsynth/algocompsynth-1 \
  docker.io/algocompsynth/algocompsynth-1r
do
  sudo docker push "$image:latest"
  if [ ${#SYNTH_RELEASE} -gt "0" ]
  then 
    sudo docker tag "$image:latest" "synth/$image:$SYNTH_RELEASE"
    sudo docker push "$image:$SYNTH_RELEASE"
  fi
done
