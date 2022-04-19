#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing mamba dependencies"
mamba install --quiet --yes \
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
mamba list
mamba clean --tarballs --yes
rm -fr $SYNTH_PROJECTS/audio

echo "Finished"
