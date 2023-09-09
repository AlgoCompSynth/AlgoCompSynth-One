#! /bin/bash

set -e

echo "Upgrading"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get upgrade -qqy

echo "Installing command line conveniences and Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ca-certificates \
  dirmngr \
  git \
  gnupg2 \
  less \
  mp3splt \
  musescore3 \
  openssh-client \
  software-properties-common \
  sox \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip

# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local
echo "Installing NVIDIA packages"
pushd /tmp
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda
popd

echo "Finished"
