#! /bin/bash

set -e
set -v

pushd $SYNTH_SOURCE
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
sudo apt-get install -y --no-install-recommends \
  $SYNTH_PACKAGES/r-cran-boot_*.deb \
  $SYNTH_PACKAGES/r-cran-cluster_*.deb \
  $SYNTH_PACKAGES/r-cran-codetools_*.deb \
  $SYNTH_PACKAGES/r-cran-foreign_*.deb \
  $SYNTH_PACKAGES/r-cran-kernsmooth_*.deb \
  $SYNTH_PACKAGES/r-cran-lattice_*.deb \
  $SYNTH_PACKAGES/r-cran-mass_*.deb \
  $SYNTH_PACKAGES/r-cran-nnet_*.deb \
  $SYNTH_PACKAGES/r-cran-spatial_*.deb

popd

echo "Finished!"
