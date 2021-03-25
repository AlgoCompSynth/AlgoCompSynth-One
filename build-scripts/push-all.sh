#! /bin/bash

set -e

sudo docker login
export SYNTH_RELEASE=0.7.4.9999
for image in \
  internal-ubuntu-builder \
  synth
do
  sudo docker push "synth/$image:latest"
  if [ ${#SYNTH_RELEASE} -gt "0" ]
  then 
    sudo docker tag "synth/$image:latest" "synth/$image:$SYNTH_RELEASE"
    sudo docker push "synth/$image:$SYNTH_RELEASE"
  fi
done
