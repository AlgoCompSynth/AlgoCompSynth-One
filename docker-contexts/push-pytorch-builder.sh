#! /bin/bash

set -e

echo "Running the builder image in the "packages" container"
docker rm -f packages || true
docker run --detach --name packages algocompsynth/pytorch-builder:latest

echo "Copying packages"
rm -fr packages
docker cp packages:/usr/local/src/packages .
ls -lt packages

echo "Tagging image with newest package name"
export PACKAGE_NAME=`ls -1t packages | head -n 1`
echo "PACKAGE_NAME: $PACKAGE_NAME"
docker tag "algocompsynth/pytorch-builder:latest" "algocompsynth/pytorch-builder:$PACKAGE_NAME"
docker images

echo "Pushing tagged image"
docker login
docker push "algocompsynth/pytorch-builder:$PACKAGE_NAME"

echo "Adding new wheel(s) to git"
cp packages/* pytorch-wheels/
git lfs install
git add pytorch-wheels/
