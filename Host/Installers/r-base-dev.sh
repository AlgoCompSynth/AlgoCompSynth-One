#! /bin/bash

set -e
set -v

echo "Enabling source packages"
if [ `lsb_release --codename --short` == "bionic" ]
then
  diff $SYNTH_INSTALLERS/sources.list.bionic /etc/apt/sources.list || true
  sudo cp $SYNTH_INSTALLERS/sources.list.bionic /etc/apt/sources.list
  diff $SYNTH_INSTALLERS/sources.list.bionic /etc/apt/sources.list 
fi
if [ `lsb_release --codename --short` == "focal" ]
then
  diff $SYNTH_INSTALLERS/sources.list.focal /etc/apt/sources.list || true
  sudo cp $SYNTH_INSTALLERS/sources.list.focal /etc/apt/sources.list
  diff $SYNTH_INSTALLERS/sources.list.focal /etc/apt/sources.list 
fi

# https://cran.r-project.org/bin/linux/ubuntu/

# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "Adding signing key"
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

if [ `lsb_release --codename --short` == "bionic" ]
then
  echo "Adding R 4.0 repository"
  sudo cp $SYNTH_INSTALLERS/CRAN.bionic.list /etc/apt/sources.list.d/
fi
if [ `lsb_release --codename --short` == "focal" ]
then
  echo "Adding R 4.0 repository"
  sudo cp $SYNTH_INSTALLERS/CRAN.focal.list /etc/apt/sources.list.d/
fi

echo "Updating cache"
sudo apt-get update -qq

export R_BROWSER="/usr/bin/chromium-browser"
export R_PAPERSIZE="letter"

# the tools don't automatically resolve dependencies
# so we have to build and install in stages
pushd $SYNTH_PACKAGES
export MAKEFLAGS="-j1"
export MAKE="make -j1"
echo "Phase 1"
sudo apt-get build-dep -y --no-install-recommends \
  r-base
apt-get source --compile \
  r-base
sudo apt-get install --no-install-recommends \
  ./r-base-core_*.deb \
  ./r-base-dev_*.deb \
  ./r-mathlib_*.deb

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
sudo apt-get install --no-install-recommends \
  ./r-cran-boot_*.deb \
  ./r-cran-cluster_*.deb \
  ./r-cran-codetools_*.deb \
  ./r-cran-foreign_*.deb \
  ./r-cran-kernsmooth_*.deb \
  ./r-cran-lattice_*.deb \
  ./r-cran-mass_*.deb \
  ./r-cran-nnet_*.deb \
  ./r-cran-spatial_*.deb

#echo "Phase 3"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-class \
  r-cran-matrix \
  r-cran-nlme
apt-get source --compile \
  r-cran-class \
  r-cran-matrix \
  r-cran-nlme
sudo apt-get install --no-install-recommends \
  ./r-cran-class_*.deb \
  ./r-cran-matrix_*.deb \
  ./r-cran-nlme_*.deb

echo "Phase 4"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-mgcv \
  r-cran-survival
apt-get source --compile --no-install-recommends \
  r-cran-mgcv \
  r-cran-survival
sudo apt-get install --no-install-recommends \
  ./r-cran-mgcv_*.deb \
  ./r-cran-survival_*.deb

echo "Phase 5"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-rpart
apt-get source --compile --no-install-recommends \
  r-cran-rpart
sudo apt-get install --no-install-recommends \
  ./r-cran-rpart_*.deb \
  ./r-recommended_*.deb

popd

echo "Finished!"
