#! /bin/bash

set -e

pushd $SYNTH_SOURCE

echo "Phase 3 build-dep"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-class \
  r-cran-matrix \
  r-cran-nlme \
  > $SYNTH_LOGS/build-dep-3.log 2>&1
echo "Phase 3 compile"
apt-get source --compile \
  r-cran-class \
  r-cran-matrix \
  r-cran-nlme \
  > $SYNTH_LOGS/compile-3.log 2>&1
mv *deb $SYNTH_PACKAGES
echo "Phase 3 install"
sudo apt-get install --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-class_*.deb \
  $SYNTH_PACKAGES/r-cran-matrix_*.deb \
  $SYNTH_PACKAGES/r-cran-nlme_*.deb \
  > $SYNTH_LOGS/install-3.log 2>&1

echo "Phase 4 build-dep"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-mgcv \
  r-cran-survival \
  > $SYNTH_LOGS/build-dep-4.log 2>&1
echo "Phase 4 compile"
apt-get source --compile --no-install-recommends \
  r-cran-mgcv \
  r-cran-survival \
  > $SYNTH_LOGS/compile-4.log 2>&1
mv *deb $SYNTH_PACKAGES
echo "Phase 4 install"
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-mgcv_*.deb \
  $SYNTH_PACKAGES/r-cran-survival_*.deb \
  > $SYNTH_LOGS/install-4.log 2>&1

echo "Phase 5 build-dep"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-data.table \
  r-cran-irkernel \
  r-cran-reticulate \
  r-cran-rpart \
  > $SYNTH_LOGS/build-dep-5.log 2>&1
echo "Phase 5 compile"
apt-get source --compile --no-install-recommends \
  r-cran-data.table \
  r-cran-irkernel \
  r-cran-reticulate \
  r-cran-rpart \
  > $SYNTH_LOGS/compile-5.log 2>&1
mv *deb $SYNTH_PACKAGES
echo "Phase 5 install"
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-data.table_*.deb \
  $SYNTH_PACKAGES/r-cran-irkernel_*.deb \
  $SYNTH_PACKAGES/r-cran-reticulate_*.deb \
  $SYNTH_PACKAGES/r-cran-rpart_*.deb \
  $SYNTH_PACKAGES/r-recommended_*.deb \
  > $SYNTH_LOGS/install-5.log 2>&1

popd

echo "Finished!"
