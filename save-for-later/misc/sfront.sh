#! /bin/bash

set -e

echo "Downloading sfront source"
rm -fr sfront sfront.tar.gz
wget http://www.cs.berkeley.edu/~lazzaro/sa/sfront.tar.gz
tar xf sfront.tar.gz
pushd sfront/src

  echo "Setting MODEL to 'march=native'"
  sed --in-place=.bak --expression='s/^MODEL.*$/MODEL = -march=native/' Makefile

  echo "Compiling sfront"
  make --jobs=`nproc` install

  popd

echo "Installing sfront globally"
sudo cp sfront/bin/sfront /usr/local/bin/
which sfront

# make examples
echo "Compiling sample files"
pushd sfront/examples

  make
  popd
