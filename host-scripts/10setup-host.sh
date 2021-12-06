#! /bin/bash

set -e

export DIST=$(. /etc/os-release;echo $ID$VERSION_ID); echo "DIST = $DIST"
export DIST_NO_DOT=`echo $DIST|sed 's/\.//'`; echo "DIST_NO_DOT = $DIST_NO_DOT"
export CODENAME=$(lsb_release -cs); echo "CODENAME = $CODENAME"

echo "Upgrading NVIDIA Container Toolkit"
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$DIST/nvidia-docker.list \
  | sed 's/$(ARCH)/arm64/' \
  | sed 's/#deb/deb/' \
  | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update
sudo apt dist-upgrade -y

echo "Enabling rootless Docker usage"
sudo usermod -aG docker $USER

echo "Setting Docker default runtime to NVIDIA"
sudo systemctl stop docker.service
diff daemon.json /etc/docker/daemon.json || true
sudo cp daemon.json /etc/docker/daemon.json
diff daemon.json /etc/docker/daemon.json
sudo systemctl start docker.service
