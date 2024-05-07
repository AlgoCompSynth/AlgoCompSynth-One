#! /usr/bin/env bash

set -e

echo "Updating packages"
sudo pacman --sync --refresh --sysupgrade

echo "Updating pacman search databases"
sudo pacman --files --refresh

echo "Setting .Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Installing 'yay'"
if [ ! -x /usr/sbin/yay ]
then
  pushd /tmp
  rm -fr yay
  echo "Cloning repository"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  echo "Compiling yay"
  makepkg -si
  yay --version
  popd
fi

echo "Updating yay search database"
yay --files --refresh

echo "Updating locate database"
sudo updatedb

echo "Finished"
