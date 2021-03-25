#! /bin/bash

set -e

sudo docker login
export SYNTH_RELEASE=0.7.4.9999
sudo docker push "synth/synth:latest"
if [ ${#SYNTH_RELEASE} -gt "0" ]
then 
  sudo docker tag "synth/synth:latest" "synth/synth:$SYNTH_RELEASE"
  sudo docker push "synth/synth:$SYNTH_RELEASE"
fi
