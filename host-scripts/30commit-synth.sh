#! /bin/bash

echo "Creating a backup"
docker tag algocompsynth/synth:latest algocompsynth/synth:backup

echo "Committing 'synth' container to 'algocompsynth/synth:latest'"
docker commit synth algocompsynth/synth:latest
docker images
