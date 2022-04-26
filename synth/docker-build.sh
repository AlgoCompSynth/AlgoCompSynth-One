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
  export BASE_IMAGE="nvcr.io/nvidia/l4t-base:r34.1"
  export IMAGE_TAG=`echo $BASE_IMAGE | sed "s/^.*://"`
  export PYTHON_VERSION="3.8"
  echo "PYTHON_VERSION: $PYTHON_VERSION"
elif [ "$JETPACK4" -gt "0" ]
then
  echo "JetPack 4 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-base:r32.7.1"
  export IMAGE_TAG=`echo $BASE_IMAGE | sed "s/^.*://"`
  export PYTHON_VERSION="3.6"
  export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
  export PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
  export TORCHAUDIO_VERSION="0.10.0"
else
  echo "ERROR: can't detect JetPack version!"
  exit -1
fi

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
