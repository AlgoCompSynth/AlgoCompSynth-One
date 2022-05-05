#! /bin/bash

set -e

echo "Defining environment variables"
export REPO=r-packages
export CODENAME=`lsb_release --codename --short`

echo "Pulling ubuntu:$CODENAME"
docker pull ubuntu:$CODENAME

echo "Building $REPO:$CODENAME"
echo "This takes a while; compiling R base is single-threaded"
echo "The build logs are in /tmp"
/usr/bin/time docker build \
  --tag $REPO:$CODENAME \
  --file Dockerfile.$CODENAME \
  . > /tmp/$REPO.log 2>&1

echo "Downloading R packages"
docker rm --force $REPO || true
docker run --detach --name $REPO
docker cp $REPO:/home/synth/Packages ..
