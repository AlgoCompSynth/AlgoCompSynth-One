#! /usr/bin/env bash

set -e

if [ ! -x /usr/sbin/yay ]
then
  echo "Installing yay"
  pushd /tmp
  rm -fr yay
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  yay --version
  popd
fi

echo "Finished"
