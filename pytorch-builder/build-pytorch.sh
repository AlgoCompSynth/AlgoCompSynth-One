#! /bin/bash

set -e
rm -f $SYNTH_LOGS/build-pytorch.log
cd $SYNTH_PROJECTS

# reference: https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

echo "Activating 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate pytorch-builder

export USE_NCCL=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"
export PYTORCH_BUILD_VERSION=$PYTORCH_VERSION
export PYTORCH_BUILD_NUMBER=1

echo "Installing Python requirements"
cd pytorch
pip install -r requirements.txt \
  >> $SYNTH_LOGS/build-pytorch.log 2>&1
pip install scikit-build \
  >> $SYNTH_LOGS/build-pytorch.log 2>&1
pip install ninja \
  >> $SYNTH_LOGS/build-pytorch.log 2>&1

echo "Building wheel"
if [ `ram_kilobytes.sh` -gt 9999999 ]
then
  /usr/bin/time python setup.py bdist_wheel \
    >> $SYNTH_LOGS/build-pytorch.log 2>&1
else
  export MAX_JOBS=6
  /usr/bin/time python setup.py bdist_wheel \
    >> $SYNTH_LOGS/build-pytorch.log 2>&1
fi

echo "Saving wheel to $PACKAGES"
cp dist/*.whl $PACKAGES/