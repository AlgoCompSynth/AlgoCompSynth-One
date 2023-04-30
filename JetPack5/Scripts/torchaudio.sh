#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  cmake \
  ffmpeg \
  ninja \
  pkg-config

if [ `find $SYNTH_WHEELS -name 'torchaudio-*.whl' | wc -l` = "0" ]
then
  echo "Building torchaudio wheel"

  cd $SYNTH_PROJECTS
  echo "Removing previous 'audio'"
  rm -fr audio*
  git clone --recurse-submodules https://github.com/pytorch/audio.git
  cd audio
  echo "Checking out v$TORCHAUDIO_VERSION"
  git checkout v$TORCHAUDIO_VERSION
  echo "Installing from source"
  export USE_CUDA=1
  export USE_FFMPEG=1 
  export BUILD_KALDI=1
  export BUILD_SOX=1
  /usr/bin/time pip wheel -v -e . --no-use-pep517
  echo "Saving torchaudio wheel"
  cp ./torchaudio-*.whl $SYNTH_WHEELS/
fi
echo "Installing torchaudio wheel"
pip install $SYNTH_WHEELS/torchaudio-*.whl

echo "Cleanup"
echo "..Removing audio project repository"
rm -fr $SYNTH_PROJECTS/audio
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
