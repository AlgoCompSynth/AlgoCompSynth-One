#! /bin/bash

echo "Committing 'synth' container to 'algocompsynth/synth:latest'"
sudo docker commit synth algocompsynth/synth:latest
sudo docker images
