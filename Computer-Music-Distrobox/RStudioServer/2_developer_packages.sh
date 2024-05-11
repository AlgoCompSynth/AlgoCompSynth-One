#! /usr/bin/env bash

set -e

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libmagick++-dev \
  libpng-dev \
  libtiff5-dev \
  libxml2-dev \
  > Logs/2_developer_packages.log 2>&1

echo "Installing developer R packages - this takes some time"
/usr/bin/time ./devel_packages.R >> Logs/2_developer_packages.log 2>&1

echo "Finished"
