#! /bin/bash

set -e

export REPO=`basename $PWD`
echo "Creating a backup - ignore missing images"
sudo docker tag $REGISTRY/$ACCOUNT/$REPO:latest $REGISTRY/$ACCOUNT/$REPO:backup || true
echo "Building $REPO"
/usr/bin/time sudo docker build --tag $REGISTRY/$ACCOUNT/$REPO:latest . > /tmp/$REPO.log 2>&1
