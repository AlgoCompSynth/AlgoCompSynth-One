export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
export WHEEL_REPO="wheel"
export SYNTH_REPO="synth"

echo "Detecting JetPack version"
export PATH=$PATH:/usr/local/cuda/bin
export JETPACK4=`nvcc --version | grep -e "10.2" | wc -l`
export JETPACK5=`nvcc --version | grep -e "11.4" | wc -l`
if [ "$JETPACK5" -gt "0" ]
then
  echo "JetPack 5 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-base:r34.1"
  export IMAGE_TAG="jp5.0"
  export PYTHON_VERSION="3.8"
  export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/ssf2v7pf5i245fk4i0q926hy4imzs2ph.whl"
  export PYTORCH_WHEEL_FILE="torch-1.11.0-cp38-cp38-linux_aarch64.whl"
  export TORCHAUDIO_VERSION="0.11.0"
elif [ "$JETPACK4" -gt "0" ]
then
  echo "JetPack 4 detected"
  export BASE_IMAGE="nvcr.io/nvidia/l4t-base:r32.7.1"
  export IMAGE_TAG="jp4.6.1"
  export PYTHON_VERSION="3.6"
  export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
  export PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
  export TORCHAUDIO_VERSION="0.10.0"
else
  echo "ERROR: can't detect JetPack version!"
  exit -1
fi

echo "Defining common envars"
export WHEEL_IMAGE="$REGISTRY/$ACCOUNT/$WHEEL_REPO:$IMAGE_TAG"
export SYNTH_IMAGE="$REGISTRY/$ACCOUNT/$SYNTH_REPO:$IMAGE_TAG"

echo "Defining CMAKE_BUILD_PARALLEL_LEVEL"
if [ `nproc` -lt "5" ]
then 
  export CMAKE_BUILD_PARALLEL_LEVEL=3
else
  export CMAKE_BUILD_PARALLEL_LEVEL=`nproc`
fi
echo "nproc: `nproc`, CMAKE_BUILD_PARALLEL_LEVEL: $CMAKE_BUILD_PARALLEL_LEVEL"
