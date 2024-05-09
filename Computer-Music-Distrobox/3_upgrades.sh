#! /usr/bin/env bash

set -e

echo "Updating packages"
yay --sync --refresh --sysupgrade

echo "Updating yay search database"
yay --files --refresh

echo "Updating locate database"
sudo updatedb

echo "Finished"
