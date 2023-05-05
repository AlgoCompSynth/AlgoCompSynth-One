echo ""
echo "Detecting JetPack version"
export PATH=$PATH:/usr/local/cuda/bin
export JETPACK_VERSION=`dpkg-query --show nvidia-jetpack | sed "s;nvidia-jetpack\t;;" | sed "s;-.*$;;"`
echo "..JETPACK_VERSION: $JETPACK_VERSION"

echo ""
echo "Setting versions to install"
export PYTHON_VERSION="3.8"
export PYTORCH_WHEEL_URL="https://developer.download.nvidia.cn/compute/redist/jp/v51/pytorch/torch-2.0.0a0+8aa34602.nv23.03-cp38-cp38-linux_aarch64.whl"
export PYTORCH_WHEEL_FILE="torch-2.0.0-cp38-cp38-linux_aarch64.whl"
export PYTORCH_VERSION="2.0.0"
export TORCHAUDIO_VERSION="2.0.1"
export TORCHVISION_VERSION="0.15.1"

export CUSIGNAL_VERSION="23.04.00"
echo "..PYTHON_VERSION: $PYTHON_VERSION"
echo "..PYTORCH_WHEEL_URL: $PYTORCH_WHEEL_URL"
echo "..PYTORCH_WHEEL_FILE: $PYTORCH_WHEEL_FILE"
echo "..PYTORCH_VERSION: $PYTORCH_VERSION"
echo "..TORCHAUDIO_VERSION: $TORCHAUDIO_VERSION"
echo "..TORCHVISION_VERSION: $TORCHVISION_VERSION"
echo "..CUSIGNAL_VERSION: $CUSIGNAL_VERSION"

echo ""
echo "Defining CMAKE_BUILD_PARALLEL_LEVEL, MAX_JOBS and MAKEFLAGS"
if [ `nproc` -lt "7" ]
then 
  export CMAKE_BUILD_PARALLEL_LEVEL=4
  export MAX_JOBS=4
  export MAKEFLAGS="-j4"
else
  export CMAKE_BUILD_PARALLEL_LEVEL=`nproc`
  export MAX_JOBS=`nproc`
  export MAKEFLAGS="-j$(nproc)"
fi
echo "..CMAKE_BUILD_PARALLEL_LEVEL: $CMAKE_BUILD_PARALLEL_LEVEL"
echo "..MAX_JOBS: $MAX_JOBS"
echo "..MAKEFLAGS: $MAKEFLAGS"

echo ""
echo "Defining virtual desktop"
export SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
export SYNTH_LOGS=$SYNTH_HOME/Logs
export SYNTH_PROJECTS=$SYNTH_HOME/Projects
export SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
export SYNTH_WHEELS=$SYNTH_HOME/Wheels
echo "..SYNTH_SCRIPTS: $SYNTH_SCRIPTS"
echo "..SYNTH_LOGS: $SYNTH_LOGS"
echo "..SYNTH_PROJECTS: $SYNTH_PROJECTS"
echo "..SYNTH_NOTEBOOKS: $SYNTH_NOTEBOOKS"
echo "..SYNTH_WHEELS: $SYNTH_WHEELS"
