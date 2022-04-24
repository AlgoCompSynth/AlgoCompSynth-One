#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing build dependencies"
pip install \
  cmake \
  ninja \
  pkg-config

cd $SYNTH_PROJECTS
echo "Removing previous 'audio'"
rm -fr audio*
git clone --recurse-submodules https://github.com/pytorch/audio.git
cd audio
echo "Checking out v$TORCHAUDIO_VERSION"
git checkout v$TORCHAUDIO_VERSION

echo "Installing 'torchaudio'"
export BUILD_SOX=1
/usr/bin/time python setup.py install

echo "Cleanup"
pip list
rm -fr $SYNTH_PROJECTS/audio

echo "Finished"
