#! /bin/bash

set -e

# compile crashes if anything from mambaforge is in PATH
if [ `echo $PATH | grep -e "mambaforge" | wc -l` -gt "0" ]
then
  echo "Removing mambaforge from PATH to prevent compile failures"
  export PATH=`echo $PATH | sed "s;$HOME/mambaforge/envs/r-reticulate/bin;;g" | sed "s;$HOME/mambaforge/condabin;;g"`
fi
echo "PATH: $PATH"

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  build-essential \
  curl \
  default-jdk \
  default-jre \
  gfortran \
  libbz2-dev \
  libcairo2-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libjbig-dev \
  libjpeg-turbo8-dev \
  libjpeg8-dev \
  libjpeg-dev \
  liblzma-dev \
  libpango1.0-dev \
  libpangocairo-1.0-0 \
  libpcre2-dev \
  libpng-dev \
  libreadline-dev \
  libtiff-dev \
  libtiff5-dev \
  qpdf \
  texinfo \
  texlive-fonts-extra \
  texlive-fonts-recommended \
  texlive-latex-extra \
  texlive-latex-recommended \
  texlive-pictures \
  texlive-xetex \
  tk-dev \
  wget \
  xorg-dev \
  zlib1g-dev

echo "Removing old R source directories"
pushd $SYNTH_PROJECTS
rm -fr R-* build_dir

echo "Downloading $R_SOURCE_TARBALL"
curl -Ls $R_SOURCE_TARBALL | tar xzf -
export R_LATEST=`ls -1 | grep -e "^R-"`
echo "Using $R_LATEST"

echo "Configuring"
mkdir --parents build_dir
cd build_dir
../$R_LATEST/configure

echo "Compiling"
make --jobs=$CMAKE_BUILD_PARALLEL_LEVEL
echo "Making standalone math library"
pushd src/nmath/standalone
make --jobs=$CMAKE_BUILD_PARALLEL_LEVEL
sudo make install
popd

echo "Installing"
sudo make install
sudo cp $SYNTH_SCRIPTS/R.conf /etc/ld.so.conf.d/
sudo /sbin/ldconfig
cd ..

echo "Finished!"
