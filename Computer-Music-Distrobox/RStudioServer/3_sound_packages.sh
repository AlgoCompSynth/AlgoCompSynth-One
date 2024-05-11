#! /usr/bin/env bash

set -e

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  cmake \
  libfftw3-dev \
  libfftw3-doc \
  > Logs/3_sound_packages.log 2>&1

echo "Installing sound R packages - this takes some time"
/usr/bin/time ./sound_packages.R >> Logs/3_sound_packages.log 2>&1

echo "Finished"
