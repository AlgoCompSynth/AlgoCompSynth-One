#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh

echo "Activating r-reticulate"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  fftw-dev \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libflac-dev \
  libogg-dev \
  libsox-dev \
  libsox-fmt-all \
  libsoxr-dev \
  flac \
  mp3splt \
  sox

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  fftw \
  libflac

echo "Installing R packages"
export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig
/usr/bin/time $SYNTH_SCRIPTS/sound.R > $SYNTH_LOGS/sound.log 2>&1

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
