#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
export REPO="synth"

echo "Detecting JetPack version"
export PATH=$PATH:/usr/local/cuda/bin
export JETPACK4=`nvcc --version | grep -e "10.2" | wc -l`
export JETPACK5=`nvcc --version | grep -e "11.4" | wc -l`
if [ "$JETPACK5" -gt "0" ]
then
  echo "JetPack 5 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r34.1.0-pth1.12-py3"
  echo "BASE_IMAGE: $BASE_IMAGE"
  export IMAGE_TAG=`echo $BASE_IMAGE | sed "s/^.*://"`
  echo "IMAGE_TAG: $IMAGE_TAB"
  export PYTHON_VERSION="3.8"
  echo "PYTHON_VERSION: $PYTHON_VERSION"
elif [ "$JETPACK4" -gt "0" ]
then
  echo "JetPack 4 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r32.7.1-pth1.10-py3"
  echo "BASE_IMAGE: $BASE_IMAGE"
  export IMAGE_TAG=`echo $BASE_IMAGE | sed "s/^.*://"`
  echo "IMAGE_TAG: $IMAGE_TAB"
  export PYTHON_VERSION="3.6"
  echo "PYTHON_VERSION: $PYTHON_VERSION"
else
  echo "ERROR: can't detect JetPack version!"
  exit -1
fi

echo "Building $REPO"
/usr/bin/time docker build \
  --build-arg "ARG_PYTHON_VERSION=$PYTHON_VERSION" \
  --build-arg "ARG_BASE_IMAGE=$BASE_IMAGE" \
  --tag $REGISTRY/$ACCOUNT/$REPO:$IMAGE_TAG \
  . > /tmp/$REPO.log 2>&1
