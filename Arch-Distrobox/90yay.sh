#! /usr/bin/env bash

set -e

if [ ! -x /usr/sbin/yay ]
then
  pushd /tmp
  rm -fr yay
  echo "Cloning repository"
  git clone https://aur.archlinux.org/yay.git > yay_clone.log 2>&1
  cd yay
  echo "Compiling yay"
  makepkg -si 2>&1 | tee yay_build.log
  yay --version
  popd
fi

echo "Finished"
