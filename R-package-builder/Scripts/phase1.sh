#! /bin/bash

set -e
set -v

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
echo "Phase 1"
sudo apt-get build-dep -y --no-install-recommends \
  r-base
apt-get source --compile \
  r-base
mv *deb $SYNTH_PACKAGES
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-base-core_*.deb \
  $SYNTH_PACKAGES/r-base-dev_*.deb

  # optional
  #$SYNTH_PACKAGES/r-mathlib_*.deb
  #$SYNTH_PACKAGES/r-base-html_*.deb \
  #$SYNTH_PACKAGES/r-doc-html_*.deb \
  #$SYNTH_PACKAGES/r-doc-info_*.deb \
  #$SYNTH_PACKAGES/r-doc-pdf_*.deb \

popd

echo "Finished!"
