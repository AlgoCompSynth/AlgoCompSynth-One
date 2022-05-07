echo ""
echo "Detecting JetPack version"
export PATH=$PATH:/usr/local/cuda/bin
export JETPACK_VERSION=`dpkg-query --show nvidia-jetpack | sed "s;nvidia-jetpack\t;;" | sed "s;-.*$;;"`
echo "JETPACK_VERSION: $JETPACK_VERSION"

echo ""
echo "Setting versions to install"
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

export CUSIGNAL_VERSION="22.04.00"
echo "PYTHON_VERSION: $PYTHON_VERSION"
echo "PYTORCH_WHEEL_URL: $PYTORCH_WHEEL_URL"
echo "PYTORCH_WHEEL_FILE: $PYTORCH_WHEEL_FILE"
echo "TORCHAUDIO_VERSION: $TORCHAUDIO_VERSION"
echo "CUSIGNAL_VERSION: $CUSIGNAL_VERSION"

echo ""
echo "Building and running deviceQuery"
pushd /usr/local/cuda/samples/1_Utilities/deviceQuery
sudo make
sudo cp deviceQuery /usr/local/bin/
popd

deviceQuery > deviceQuery.txt

echo ""
echo "Defining CUPY_NVCC_GENERATE_CODE"
export CUDA_CAPABILITY=`grep -e 'CUDA Capability Major/Minor version number:' deviceQuery.txt | sed "s/^.*:  *//" | sed "s/\.//"`
export CUPY_NVCC_GENERATE_CODE="arch=compute_$CUDA_CAPABILITY,code=sm_$CUDA_CAPABILITY"
echo "CUPY_NVCC_GENERATE_CODE: $CUPY_NVCC_GENERATE_CODE"

echo ""
echo "Defining CMAKE_BUILD_PARALLEL_LEVEL and MAKEFLAGS"
if [ `nproc` -lt "5" ]
then 
  export CMAKE_BUILD_PARALLEL_LEVEL=3
  export MAKEFLAGS="-j3"
else
  export CMAKE_BUILD_PARALLEL_LEVEL=`nproc`
  export MAKEFLAGS="-j$(nproc)"
fi
echo "CMAKE_BUILD_PARALLEL_LEVEL: $CMAKE_BUILD_PARALLEL_LEVEL"
echo "MAKEFLAGS: $MAKEFLAGS"

echo ""
echo "Defining virtual desktop"
export SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
export SYNTH_LOGS=$SYNTH_HOME/Logs
export SYNTH_PROJECTS=$SYNTH_HOME/Projects
export SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
export SYNTH_WHEELS=$SYNTH_HOME/Wheels
echo "SYNTH_SCRIPTS: $SYNTH_SCRIPTS"
echo "SYNTH_LOGS: $SYNTH_LOGS"
echo "SYNTH_PROJECTS: $SYNTH_PROJECTS"
echo "SYNTH_NOTEBOOKS: $SYNTH_NOTEBOOKS"
echo "SYNTH_WHEELS: $SYNTH_WHEELS"
