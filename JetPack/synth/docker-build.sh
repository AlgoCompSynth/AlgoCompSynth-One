#! /bin/bash

set -e

echo "Defining environment variables"
source ../jetpack-envars.sh
export REPO=$SYNTH_REPO

echo "Pulling $BASE_IMAGE"
docker pull $BASE_IMAGE

echo "Editing Dockerfile"
sed "s;--from=WHEEL_IMAGE;--from=$WHEEL_IMAGE;" Dockerfile.template > Dockerfile

echo "Building $REPO"
/usr/bin/time docker build \
  --build-arg "ARG_BASE_IMAGE=$BASE_IMAGE" \
  --build-arg "ARG_WHEEL_IMAGE=$WHEEL_IMAGE" \
  --build-arg "ARG_PYTHON_VERSION=$PYTHON_VERSION" \
  --tag $REGISTRY/$ACCOUNT/$REPO:$IMAGE_TAG \
  . > /tmp/$REPO.log 2>&1
