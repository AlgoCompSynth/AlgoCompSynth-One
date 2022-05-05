#! /bin/bash

set -e

pushd $SYNTH_SOURCE
echo "Phase 2 build-dep"
sudo apt-get build-dep -y --no-install-recommends \
  r-cran-boot \
  r-cran-cluster \
  r-cran-codetools \
  r-cran-foreign \
  r-cran-kernsmooth \
  r-cran-lattice \
  r-cran-mass \
  r-cran-nnet \
  r-cran-spatial \
  > $SYNTH_LOGS/build-dep-2.log 2>&1
echo "Phase 2 compile"
apt-get source --compile \
  r-cran-boot \
  r-cran-cluster \
  r-cran-codetools \
  r-cran-foreign \
  r-cran-kernsmooth \
  r-cran-lattice \
  r-cran-mass \
  r-cran-nnet \
  r-cran-spatial \
  > $SYNTH_LOGS/compile-2.log 2>&1
mv *deb $SYNTH_PACKAGES
echo "Phase 2 install"
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-boot_*.deb \
  $SYNTH_PACKAGES/r-cran-cluster_*.deb \
  $SYNTH_PACKAGES/r-cran-codetools_*.deb \
  $SYNTH_PACKAGES/r-cran-foreign_*.deb \
  $SYNTH_PACKAGES/r-cran-kernsmooth_*.deb \
  $SYNTH_PACKAGES/r-cran-lattice_*.deb \
  $SYNTH_PACKAGES/r-cran-mass_*.deb \
  $SYNTH_PACKAGES/r-cran-nnet_*.deb \
  $SYNTH_PACKAGES/r-cran-spatial_*.deb \
  > $SYNTH_LOGS/install-2.log 2>&1

popd

echo "Finished!"
