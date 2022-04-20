#! /bin/bash

set -e
rm -f $SYNTH_LOGS/clone-pytorch.log
cd $SYNTH_PROJECTS

# reference: https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

echo "Downloading PyTorch source"
rm -fr pytorch*
/usr/bin/time git clone --recursive --branch v$PYTORCH_VERSION http://github.com/pytorch/pytorch \
  >> $SYNTH_LOGS/clone-pytorch.log 2>&1
cd pytorch

echo "Applying patch"
patch --backup --strip=1 < $SYNTH_SCRIPTS/$PATCHFILE \
  >> $SYNTH_LOGS/clone-pytorch.log 2>&1
