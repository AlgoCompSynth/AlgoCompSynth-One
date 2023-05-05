#! /bin/bash

set -e

source ../mamba-init.sh
echo "MAMBAFORGE_HOME=$MAMBAFORGE_HOME"
export LOGFILE=$PWD/build-pytorch-wheel.log
echo "LOGFILE=$LOGFILE"

export PYTORCH_VERSION="2.0.0"
echo "Default PyTorch version is $PYTORCH_VERSION"
echo "If that's OK press 'Enter' to accept it."
echo "Otherwise enter a different version."
read -p "PyTorch version?"

# check length
if [ "${#REPLY}" -ge "5" ]
then
  echo "Setting PYTORCH_VERSION to $REPLY"
  export PYTORCH_VERSION=$REPLY
fi

export PYTHON_VERSION="3.11"
echo "Default Python version is $PYTHON_VERSION"
echo "If that's OK press 'Enter' to accept it."
echo "Otherwise enter a different version."
read -p "Python version?"

# check length
if [ "${#REPLY}" -ge "3" ]
then
  echo "Setting PYTHON_VERSION to $REPLY"
  export PYTHON_VERSION=$REPLY
fi

export ENVNAME="torch-$PYTORCH_VERSION-python-$PYTHON_VERSION"
echo "ENVNAME=$ENVNAME"
echo "Creating and activating fresh $ENVNAME environment"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba create --yes --force --quiet \
  --name $ENVNAME \
  python=$PYTHON_VERSION \
  cmake \
  pyyaml \
  typing_extensions
mamba activate $ENVNAME

echo "Cloning fresh PyTorch repository"
rm -fr pytorch*
/usr/bin/time git clone --recursive \
  --branch=v$PYTORCH_VERSION \
  https://github.com/pytorch/pytorch.git
cd pytorch

echo "Setting environment variables"
export USE_NCCL=0
export USE_DISTRIBUTED=1                    # skip setting this if you want to enable OpenMPI backend
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="7.2;8.7" # JetPack 5 wheels for Xavier/Orin
export PYTORCH_BUILD_VERSION=$PYTORCH_VERSION
export PYTORCH_BUILD_NUMBER=1
export PATH=$PATH:/usr/local/cuda/bin

echo "Starting background job to build PyTorch wheel"
/usr/bin/time python setup.py bdist_wheel \
  > $LOGFILE 2>&1 &
export BUILD_JOB_PID=$!
echo "BUILD_JOB_PID=$BUILD_JOB_PID"

echo ""
echo "Waiting 30 seconds in case it crashes"
sleep 30
echo "To monitor progress use"
echo ""
echo "tail -f $LOGFILE"
echo ""
echo ""
echo "Exiting in ten seconds ..."
sleep 10
echo "Finished"
