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

export R_BROWSER="/usr/bin/chromium-browser"
export R_PAPERSIZE="letter"

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
sudo apt-get install --no-install-recommends \
  $SYNTH_PACKAGES/r-base-core_*.deb \
  $SYNTH_PACKAGES/r-base-dev_*.deb \
  $SYNTH_PACKAGES/r-mathlib_*.deb

  # optional
  #./r-base-html_*.deb \
  #./r-doc-html_*.deb \
  #./r-doc-info_*.deb \
  #./r-doc-pdf_*.deb \

echo "Phase 2"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-boot \
  r-cran-cluster \
  r-cran-codetools \
  r-cran-foreign \
  r-cran-kernsmooth \
  r-cran-lattice \
  r-cran-mass \
  r-cran-nnet \
  r-cran-spatial
apt-get source --compile \
  r-cran-boot \
  r-cran-cluster \
  r-cran-codetools \
  r-cran-foreign \
  r-cran-kernsmooth \
  r-cran-lattice \
  r-cran-mass \
  r-cran-nnet \
  r-cran-spatial
mv *deb $SYNTH_PACKAGES
sudo apt-get install --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-boot_*.deb \
  $SYNTH_PACKAGES/r-cran-cluster_*.deb \
  $SYNTH_PACKAGES/r-cran-codetools_*.deb \
  $SYNTH_PACKAGES/r-cran-foreign_*.deb \
  $SYNTH_PACKAGES/r-cran-kernsmooth_*.deb \
  $SYNTH_PACKAGES/r-cran-lattice_*.deb \
  $SYNTH_PACKAGES/r-cran-mass_*.deb \
  $SYNTH_PACKAGES/r-cran-nnet_*.deb \
  $SYNTH_PACKAGES/r-cran-spatial_*.deb

#echo "Phase 3"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-class \
  r-cran-matrix \
  r-cran-nlme
apt-get source --compile \
  r-cran-class \
  r-cran-matrix \
  r-cran-nlme
mv *deb $SYNTH_PACKAGES
sudo apt-get install --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-class_*.deb \
  $SYNTH_PACKAGES/r-cran-matrix_*.deb \
  $SYNTH_PACKAGES/r-cran-nlme_*.deb

echo "Phase 4"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-mgcv \
  r-cran-survival
apt-get source --compile --no-install-recommends \
  r-cran-mgcv \
  r-cran-survival
mv *deb $SYNTH_PACKAGES
sudo apt-get install --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-mgcv_*.deb \
  $SYNTH_PACKAGES/r-cran-survival_*.deb

echo "Phase 5"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-rpart
apt-get source --compile --no-install-recommends \
  r-cran-rpart
mv *deb $SYNTH_PACKAGES
sudo apt-get install --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-rpart_*.deb \
  $SYNTH_PACKAGES/r-recommended_*.deb

popd

echo "Finished!"
