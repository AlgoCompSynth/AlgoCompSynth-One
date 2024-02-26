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

echo "Testing whether to install CUDA 11.8"
if [ `dpkg-query -l | grep -e "cuda-11-8" | grep -e "^ii" | wc -l` -gt "0" ]
then
  echo "..CUDA 11.8 is installed - exiting normally"
  exit 0
else
  echo "..Installing CUDA 11.8"
  # https://developer.nvidia.com/cuda-11-8-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local
  export CUDA_VERSION="11.8.0"
  export CUDA_PACKAGE="cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb"
  export CUDA_KEYRING="/var/cuda-repo-wsl-ubuntu-11-8-local/cuda-*-keyring.gpg"

  pushd /tmp
  rm -f *.deb *.pin
  wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
  sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
  wget https://developer.download.nvidia.com/compute/cuda/$CUDA_VERSION/local_installers/$CUDA_PACKAGE
  sudo dpkg -i $CUDA_PACKAGE
  sudo cp $CUDA_KEYRING /usr/share/keyrings/
  sudo apt-get update
  sudo apt-get -y install cuda
  popd

  echo "Installing 'nvtop'"
  sudo add-apt-repository -y ppa:flexiondotorg/nvtop
  sudo apt install nvtop

fi

echo "Finished"
