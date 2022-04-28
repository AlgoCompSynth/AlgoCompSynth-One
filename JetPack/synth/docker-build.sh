#! /bin/bash

set -e

echo "Defining environment variables"
source ../jetpack-envars.sh
export REPO=$SYNTH_REPO

echo "Pulling $BASE_IMAGE"
docker pull $BASE_IMAGE

echo "Building $REPO"
/usr/bin/time docker build \
  --build-arg "ARG_BASE_IMAGE=$BASE_IMAGE" \
  --build-arg "ARG_PYTHON_VERSION=$PYTHON_VERSION" \
  --build-arg "ARG_PYTORCH_WHEEL_URL=$PYTORCH_WHEEL_URL" \
  --build-arg "ARG_PYTORCH_WHEEL_FILE=$PYTORCH_WHEEL_FILE" \
  --build-arg "ARG_TORCHAUDIO_VERSION=$TORCHAUDIO_VERSION" \
  --tag $REGISTRY/$ACCOUNT/$REPO:$IMAGE_TAG \
  . > /tmp/$REPO.log 2>&1
