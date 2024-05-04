#! /usr/bin/env bash

set -e

echo "Ranking mirrors"
./rank-mirrors.sh

echo "Initializing pacman key"
sudo pacman-key --init

echo "Updating packages"
sudo pacman -Syu

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

echo "Setting makepkg.conf make jobs to `nproc`"
diff makepkg.conf /etc/makepkg.conf || true
sudo cp makepkg.conf /etc/makepkg.conf

echo "Updating package search databases"
sudo pacman -Fy
yay -Fy

echo "Finished"
