#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing build dependencies"
pip install \
  cmake \
  ninja

cd $SYNTH_PROJECTS
echo "Removing previous 'audio'"
rm -fr audio*
git clone --recurse-submodules https://github.com/pytorch/audio.git
cd audio
echo "Checking out v$TORCHAUDIO_VERSION"
git checkout v$TORCHAUDIO_VERSION

echo "Patching torchaudio source"
# see https://github.com/dusty-nv/jetson-containers/blob/master/Dockerfile.pytorch
# and https://github.com/pytorch/audio/issues/2295
sed -i \
  's#  URL https://zlib.net/zlib-1.2.11.tar.gz#  URL https://zlib.net/zlib-1.2.12.tar.gz#g' \
  third_party/zlib/CMakeLists.txt \
  || echo "failed to patch torchaudio/third_party/zlib/CMakeLists.txt"
sed -i \
  's#  URL_HASH SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1#  URL_HASH SHA256=91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9#g' \
  third_party/zlib/CMakeLists.txt \
  || echo "failed to patch torchaudio/third_party/zlib/CMakeLists.txt"

echo "Building 'torchaudio' wheel"
export BUILD_SOX=1
/usr/bin/time python setup.py bdist_wheel --universal

echo "Saving 'torchaudio' wheel to $SYNTH_WHEELS"
cp dist/torchaudio-*.whl $SYNTH_WHEELS/

echo "Installing 'torchaudio' wheel"
pip install dist/torchaudio-*.whl

echo "Cleanup"
pip list
rm -fr $SYNTH_PROJECTS/audio

echo "Finished"
