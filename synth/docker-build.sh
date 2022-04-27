#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
export REPO="synth"
export FROM_REPO="wheel-builder"

echo "Detecting JetPack version"
export PATH=$PATH:/usr/local/cuda/bin
export JETPACK4=`nvcc --version | grep -e "10.2" | wc -l`
export JETPACK5=`nvcc --version | grep -e "11.4" | wc -l`
if [ "$JETPACK5" -gt "0" ]
then
  echo "JetPack 5 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-base:r34.1"
  export IMAGE_TAG=`echo $BASE_IMAGE | sed "s/^.*://"`
  export FROM_IMAGE="$REGISTRY/$ACCOUNT/$FROM_REPO:$IMAGE_TAG"
  export PYTHON_VERSION="3.8"
elif [ "$JETPACK4" -gt "0" ]
then
  echo "JetPack 4 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-base:r32.7.1"
  export IMAGE_TAG=`echo $BASE_IMAGE | sed "s/^.*://"`
  export FROM_IMAGE="$REGISTRY/$ACCOUNT/$FROM_REPO:$IMAGE_TAG"
  export PYTHON_VERSION="3.6"
else
  echo "ERROR: can't detect JetPack version!"
  exit -1
fi

echo "Pulling $BASE_IMAGE"
docker pull $BASE_IMAGE

echo "Building $REPO"
/usr/bin/time docker build \
  --build-arg "ARG_BASE_IMAGE=$BASE_IMAGE" \
  --build-arg "ARG_FROM_IMAGE=$FROM_IMAGE" \
  --build-arg "ARG_PYTHON_VERSION=$PYTHON_VERSION" \
  --tag $REGISTRY/$ACCOUNT/$REPO:$IMAGE_TAG \
  . > /tmp/$REPO.log 2>&1
