#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
export REPO="wheel-builder"

echo "Creating a backup - ignore missing images"
docker tag $REGISTRY/$ACCOUNT/$REPO:latest $REGISTRY/$ACCOUNT/$REPO:backup || true
echo "Building $REPO"
/usr/bin/time docker build --tag $REGISTRY/$ACCOUNT/$REPO:latest . > /tmp/$REPO.log 2>&1
