#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate

if [ `find $SYNTH_WHEELS -name 'torchaudio-*.whl' | wc -l` = "0" ]
then
  echo "Building torchaudio wheel"

  cd $SYNTH_PROJECTS
  echo "Removing previous 'audio'"
  rm -fr audio*
  git clone --branch=v$TORCHAUDIO_VERSION https://github.com/pytorch/audio.git
  cd audio
  echo "Installing from source"
  export USE_CUDA=1
  export USE_CUDNN=1
  export USE_FFMPEG=1 
  export BUILD_KALDI=1
  export BUILD_SOX=1
  /usr/bin/time python setup.py bdist_wheel
  echo "Saving torchaudio wheel"
  cp dist/torchaudio-*.whl $SYNTH_WHEELS/
fi
echo "Installing torchaudio wheel - dependencies built into r-reticulate"
pip install --no-deps $SYNTH_WHEELS/torchaudio-*.whl

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
