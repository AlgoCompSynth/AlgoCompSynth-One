#! /usr/bin/env bash

set -e

echo "Updating packages"
sudo pacman --sync --refresh --sysupgrade

echo "Updating pacman search databases"
sudo pacman --files --refresh

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

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Creating $HOME/Projects directory"
mkdir --parents $HOME/Projects

echo "Copying utility scripts to $HOME"
cp vimrc* edit-me-then-run-4-git-config.sh start_jupyter_lab.sh $HOME/

echo "Finished"
