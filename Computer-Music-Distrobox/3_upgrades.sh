#! /usr/bin/env bash

set -e

echo "Updating packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq && sudo apt-get upgrade -qqy

echo "Updating apt-file database"
sudo apt-file update > /dev/null 2>&1

echo "Updating locate database"
sudo updatedb > /dev/null 2>&1

echo "Updating manual database"
sudo mandb > /dev/null 2>&1

echo "Finished"
