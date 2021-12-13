#! /bin/bash

set -e
rm -f $LOGS/clone-pytorch.log
cd $SOURCE_DIR

# reference: https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

echo "Downloading PyTorch source"
rm -fr pytorch
/usr/bin/time git clone --recursive --branch v1.10.0 http://github.com/pytorch/pytorch \
  >> $LOGS/clone-pytorch.log 2>&1
cd pytorch

echo "Applying patch"
patch --backup --strip=1 < $SCRIPTS/pytorch-1.10-jetpack-4.5.1.patch \
  >> $LOGS/clone-pytorch.log 2>&1
