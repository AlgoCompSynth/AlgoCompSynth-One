#! /bin/bash

set -e

echo "Defining environment variables"
export REPO=r-packages
export CODENAME=`lsb_release --codename --short`

echo "Pulling ubuntu:$CODENAME"
docker pull ubuntu:$CODENAME

echo "Building $REPO:$CODENAME"
/usr/bin/time docker build \
  --tag $REPO:$CODENAME \
  --file Dockerfile.$CODENAME \
  . #> /tmp/$REPO.log 2>&1
