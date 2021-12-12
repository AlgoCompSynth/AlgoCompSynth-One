#! /bin/bash

set -e
rm -f $LOGS/build-pytorch.log
cd $SOURCE_DIR

# reference: https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

echo "Creating fresh 'gnash' virtualenv"
virtualenv --clear $WORKON_HOME/gnash -p /usr/bin/python$PYTHON_VERSION` \
  >> $LOGS/build-pytorch.log 2>&1

# activate it
source $WORKON_HOME/gnash/bin/activate

echo "Downloading PyTorch source"
/usr/bin/time git clone --recursive --branch v$PYTORCH_VERSION.0 http://github.com/pytorch/pytorch \
  >> $LOGS/build-pytorch.log 2>&1
cd pytorch

echo "Applying patch"
patch --backup --strip=1 < $SCRIPTS/$PATCHFILE \
  >> $LOGS/build-pytorch.log 2>&1

export USE_NCCL=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"
export PYTORCH_BUILD_VERSION=$PYTORCH_VERSION.0
export PYTORCH_BUILD_NUMBER=1

echo "Installing Python requirements"
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
