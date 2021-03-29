#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd $1

  export REPO=`basename $PWD`
  echo "Creating a backup - ignore missing images"
  sudo docker tag $REGISTRY/$ACCOUNT/$REPO:latest $REGISTRY/$ACCOUNT/$REPO:backup || true
  echo "Building $REPO"
  /usr/bin/time sudo docker build --tag $REGISTRY/$ACCOUNT/$REPO:latest . > /tmp/$REPO.log 2>&1
  popd

docker images
