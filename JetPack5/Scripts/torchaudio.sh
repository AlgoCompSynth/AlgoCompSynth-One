#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Building torchaudio wheel"

cd $SYNTH_PROJECTS
echo "Removing previous 'audio'"
rm -fr audio*
git clone --branch=v$TORCHAUDIO_VERSION https://github.com/pytorch/audio.git
cd audio

# https://pytorch.org/audio/stable/build.jetson.html
echo "Installing from source"
export USE_CUDA=1
export USE_FFMPEG=1
/usr/bin/time pip install -e . --no-use-pep517

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
