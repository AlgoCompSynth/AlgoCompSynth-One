echo "Detecting JetPack version"
export PATH=$PATH:/usr/local/cuda/bin
export JETPACK_VERSION=`dpkg-query --show nvidia-jetpack | sed "s;nvidia-jetpack\t;;" | sed "s;-.*$;;"`
echo "JETPACK_VERSION: $JETPACK_VERSION"

if [ "$JETPACK_VERSION" = "5.0" ]
then
  export PYTHON_VERSION="3.8"
  export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/ssf2v7pf5i245fk4i0q926hy4imzs2ph.whl"
  export PYTORCH_WHEEL_FILE="torch-1.11.0-cp38-cp38-linux_aarch64.whl"
  export TORCHAUDIO_VERSION="0.11.0"
elif [ "$JETPACK_VERSION" = "4.6.1" ]
then
  export PYTHON_VERSION="3.6"
  export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
  export PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
  export TORCHAUDIO_VERSION="0.10.0"
else
  echo "ERROR: can't detect JetPack version!"
  exit -1
fi

echo "PYTHON_VERSION: $PYTHON_VERSION"
echo "PYTORCH_WHEEL_URL: $PYTORCH_WHEEL_URL"
echo "PYTORCH_WHEEL_FILE: $PYTORCH_WHEEL_FILE"
echo "TORCHAUDIO_VERSION: $TORCHAUDIO_VERSION"

echo "Building and running 'deviceQuery'"
pushd /usr/local/cuda/samples/1_Utilities/deviceQuery
sudo make
sudo cp deviceQuery /usr/local/bin/
popd

deviceQuery > deviceQuery.txt

echo "Defining CMAKE_BUILD_PARALLEL_LEVEL"
if [ `nproc` -lt "5" ]
then 
  export CMAKE_BUILD_PARALLEL_LEVEL=3
else
  export CMAKE_BUILD_PARALLEL_LEVEL=`nproc`
fi
