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

  echo "Patching source"
  if [ "$TORCHAUDIO_VERSION" == "0.11.0" ]
  then

    # https://github.com/dusty-nv/jetson-containers/blob/master/Dockerfile.pytorch
    # https://github.com/pytorch/audio/issues/2295
    sed -i \
      's#  URL https://zlib.net/zlib-1.2.11.tar.gz#  URL https://zlib.net/zlib-1.2.12.tar.gz#g' \
      third_party/zlib/CMakeLists.txt || echo "failed to patch torchaudio/third_party/zlib/CMakeLists.txt"
    sed -i \
      's#  URL_HASH SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1#  URL_HASH SHA256=91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9#g' \
      third_party/zlib/CMakeLists.txt || echo "failed to patch torchaudio/third_party/zlib/CMakeLists.txt"

  fi

  export BUILD_SOX=1
  /usr/bin/time python setup.py bdist_wheel

  echo "Saving torchaudio wheel"
  cp dist/torchaudio-*.whl $SYNTH_WHEELS/

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
