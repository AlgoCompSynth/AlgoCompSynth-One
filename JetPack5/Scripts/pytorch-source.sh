#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Building pytorch wheel"

cd $SYNTH_PROJECTS
#echo "Removing previous 'pytorch'"
#rm -fr pytorch*
#git clone --recursive --branch=v$PYTORCH_VERSION https://github.com/pytorch/pytorch.git
cd pytorch
echo "Installing from source"
export USE_NCCL=0
export USE_DISTRIBUTED=0                    # skip setting this if you want to enable OpenMPI backend
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="$CUDA_CAPABILITY_WITH_DOT"   # or "7.2;8.7" for JetPack 5 wheels for Xavier/Orin

export PYTORCH_BUILD_VERSION=$PYTORCH_VERSION  # without the leading 'v', e.g. 1.3.0 for PyTorch v1.3.0
export PYTORCH_BUILD_NUMBER=1

#/usr/bin/time python setup.py bdist_wheel
echo "Saving pytorch wheel"
cp dist/torch-*.whl $SYNTH_WHEELS/
echo "Installing pytorch wheel"
pip install --upgrade protobuf
pip install $SYNTH_WHEELS/torch-*.whl

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
