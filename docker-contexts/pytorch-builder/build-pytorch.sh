#! /bin/bash

set -e
rm -f $LOGS/build-pytorch.log
cd $SOURCE_DIR

# reference: https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

echo "Activating 'gnash' conda environment"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate gnash

export USE_NCCL=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"
export PYTORCH_BUILD_VERSION=1.10.0
export PYTORCH_BUILD_NUMBER=1

echo "Installing Python requirements"
cd pytorch
diff requirements.txt $SCRIPTS/pytorch-from-source-requirements.txt || true
pip install -r $SCRIPTS/pytorch-from-source-requirements.txt \
  >> $LOGS/build-pytorch.log 2>&1
pip install scikit-build \
  >> $LOGS/build-pytorch.log 2>&1
pip install ninja \
  >> $LOGS/build-pytorch.log 2>&1

echo "Building wheel"
/usr/bin/time python setup.py bdist_wheel \
  >> $LOGS/build-pytorch.log 2>&1

echo "Saving wheel to $PACKAGES"
cp dist/*.whl $PACKAGES/
