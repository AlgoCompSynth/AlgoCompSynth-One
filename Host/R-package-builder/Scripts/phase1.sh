#! /bin/bash

set -e

echo "Getting codename"
export CODENAME=`lsb_release --codename --short`

echo "Enabling source packages"
  diff $SYNTH_SCRIPTS/sources.list.$CODENAME /etc/apt/sources.list || true
  sudo cp $SYNTH_SCRIPTS/sources.list.$CODENAME /etc/apt/sources.list
  diff $SYNTH_SCRIPTS/sources.list.$CODENAME /etc/apt/sources.list 

# https://cran.r-project.org/bin/linux/ubuntu/

# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "Adding signing key"
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

echo "Adding R 4.0 repository"
sudo cp $SYNTH_SCRIPTS/CRAN.$CODENAME.list /etc/apt/sources.list.d/

echo "Updating cache"
sudo apt-get update -qq

# the tools don't automatically resolve dependencies
# so we have to build and install in stages
pushd $SYNTH_SOURCE
export MAKEFLAGS="-j1"
export MAKE="make -j1"
echo "Phase 1 build-dep"
/usr/bin/time sudo apt-get build-dep -y --no-install-recommends \
  r-base \
  > $SYNTH_LOGS/build-dep-1.log 2>&1
echo "Phase 1 compile"
/usr/bin/time apt-get source --compile \
  r-base \
  > $SYNTH_LOGS/compile-1.log 2>&1
mv *deb $SYNTH_PACKAGES
echo "Phase 1 install"
/usr/bin/time sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-base-*.deb \
  $SYNTH_PACKAGES/r-doc-*.deb \
  $SYNTH_PACKAGES/r-mathlib_*.deb \
  > $SYNTH_LOGS/install-1.log 2>&1

popd

echo "Finished!"
