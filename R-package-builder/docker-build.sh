#! /bin/bash

set -e

echo "Defining environment variables"
source ../jetpack-envars.sh
export REPO=$WHEEL_REPO
export CUDA_INSTALL="developer"

echo "Pulling $BASE_IMAGE"
docker pull $BASE_IMAGE

echo "Building $REPO"
/usr/bin/time docker build \
  --build-arg "ARG_BASE_IMAGE=$BASE_IMAGE" \
  --build-arg "ARG_CMAKE_BUILD_PARALLEL_LEVEL=$CMAKE_BUILD_PARALLEL_LEVEL" \
  --build-arg "ARG_CUDA_INSTALL=$CUDA_INSTALL" \
  --build-arg "ARG_IMAGE_TAG=$IMAGE_TAG" \
  --build-arg "ARG_MAKEFLAGS=$MAKEFLAGS" \
  --build-arg "ARG_PYTHON_VERSION=$PYTHON_VERSION" \
  --build-arg "ARG_PYTORCH_WHEEL_URL=$PYTORCH_WHEEL_URL" \
  --build-arg "ARG_PYTORCH_WHEEL_FILE=$PYTORCH_WHEEL_FILE" \
  --build-arg "ARG_TORCHAUDIO_VERSION=$TORCHAUDIO_VERSION" \
  --tag $REPO:$IMAGE_TAG \
  . > /tmp/$REPO.log 2>&1