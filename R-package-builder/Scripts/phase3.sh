#! /bin/bash

set -e
set -v

pushd $SYNTH_SOURCE

echo "Phase 3"
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
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-mgcv_*.deb \
  $SYNTH_PACKAGES/r-cran-survival_*.deb

echo "Phase 5"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-rpart
apt-get source --compile --no-install-recommends \
  r-cran-rpart
mv *deb $SYNTH_PACKAGES
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-rpart_*.deb \
  $SYNTH_PACKAGES/r-recommended_*.deb

popd

echo "Finished!"
