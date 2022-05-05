#! /bin/bash

set -e

echo "Building R packages with Docker"
echo "This takes a while; compiling R base is single-threaded"
pushd ../R-package-builder
./docker-build.sh > docker-build.log 2>&1
popd

echo "Installing R packages"
pushd Packages
sudo apt-get install -y --no-install-recommends \
  ./r-*.deb
popd

echo "Enabling R kernel in JupyterLab"
Rscript -e "IRkernel::installspec()"

echo "Finished!"
