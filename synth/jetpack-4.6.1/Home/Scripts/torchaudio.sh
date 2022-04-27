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

echo "Building torchaudio wheel"
export BUILD_SOX=1
/usr/bin/time python setup.py bdist_wheel

echo "Saving torchaudio wheel"
cp dist/torchaudio-*.whl $SYNTH_WHEELS/

echo "Installing torchaudio wheel"
pip install dist/torchaudio-*.whl

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
