#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e
rm -f $LOGS/R.log
cd $SOURCE_DIR

# The binaries for many GIS operations in "Bionic"
# are obsolete. In particular, the PostgreSQL client
# "liqpq" is for PostgreSQL 10 and will not connect
# to more recent PostgreSQL services. Adding the
# PostgreSQL Global Development Group repo gives
# the latest stable GIS packages.

# see https://wiki.postgresql.org/wiki/Apt

echo "Installing PGDG Linux repository"
curl -Ls https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  >> $LOGS/R.log 2>&1
apt-get update \
  >> $LOGS/R.log 2>&1

echo "Installing build dependencies"
apt-get install -y --no-install-recommends \
  default-jdk-headless \
  gfortran \
  libbz2-dev \
  libcairo2-dev \
  libgdal-dev \
  libgit2-dev \
  libicu-dev \
  libjpeg-turbo8-dev \
  libjpeg8-dev \
  liblzma-dev \
  libncurses-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libreadline-dev \
  libtiff5-dev \
  libudunits2-dev \
  texinfo \
  tk-dev \
  zlib1g-dev \
  >> $LOGS/R.log 2>&1
apt-get clean \
  >> $LOGS/R.log 2>&1

echo "Removing old R source directories"
rm -fr R-*

export WEBSITE="https://cloud.r-project.org/src/base"
export RELEASE_DIR="R-$R_VERSION_MAJOR"
export R_TARBALL="$R_LATEST.tar.gz"

echo "Downloading $WEBSITE/$RELEASE_DIR/$R_TARBALL"
curl -Ls "$WEBSITE/$RELEASE_DIR/$R_TARBALL" | tar xzf -
echo "Using $R_LATEST"

echo "Configuring build"
mkdir --parents build-dir

pushd build-dir
  ../$R_LATEST/configure --enable-R-shlib \
  >> $LOGS/R.log 2>&1

  echo "Compiling"
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGS/R.log 2>&1

  echo "Making standalone math library"
  pushd src/nmath/standalone
    /usr/bin/time make --jobs=`nproc` \
      >> $LOGS/R.log 2>&1
    make install \
      >> $LOGS/R.log 2>&1
    popd

  echo "Installing"
  make install \
    >> $LOGS/R.log 2>&1
  popd

echo "Cleanup"
cd $SOURCE_DIR
rm -fr R-* build-dir

echo "Configuring R"
ldconfig
R CMD javareconf \
  >> $LOGS/R.log 2>&1

echo "Updating packages"
Rscript -e \
  "update.packages(ask = FALSE, quiet = TRUE, repos = 'https://cloud.r-project.org/')" \
  >> $LOGS/R.log 2>&1

echo "Cleanup"
rm -fr $SOURCE_DIR/R-* $SOURCE_DIR/build-dir
