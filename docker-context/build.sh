#! /bin/bash

set -e

echo "Creating a backup - you can ignore missing images"
sudo docker tag algocompsynth:latest algocompsynth:backup || true
echo "Building 'algocompsynth'"
/usr/bin/time sudo docker build --tag algocompsynth:latest .
sudo docker images
