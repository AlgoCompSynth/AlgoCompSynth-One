#! /usr/bin/env bash

set -e

echo "Ranking mirrors"
./rank-mirrors.sh

echo "Initializing pacman key"
sudo pacman-key --init

echo "Updating packages"
sudo pacman --sync --refresh --sysupgrade

echo "Updating package search databases"
sudo pacman --files --refresh

echo "Setting .Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Finished"
