#! /usr/bin/env bash

set -e

export DBX_CONTAINER_NAME="${1:-CMD}"
export DBX_CONTAINER_HOME_PREFIX="${2:-$HOME/dbx-homes}"
export DBX_CONTAINER_IMAGE="${3:-quay.io/toolbx/arch-toolbox:latest}"
export DBX_CONTAINER_DIRECTORY="${DBX_CONTAINER_HOME_PREFIX}/${DBX_CONTAINER_NAME}"

echo "Distrobox named '$DBX_CONTAINER_NAME' with home directory"
echo "'$DBX_CONTAINER_DIRECTORY' will be created from image"
echo "'$DBX_CONTAINER_IMAGE'"
echo ""
echo "Existing distrobox and home directory will be removed."
echo ""
echo "Sleeping 20 seconds. If these are not what you want, exit with CTL-C"
sleep 20

echo "Pulling $DBX_CONTAINER_IMAGE"
podman pull $DBX_CONTAINER_IMAGE

echo "Removing old distrobox home directory"
rm --force --recursive ${DBX_CONTAINER_HOME_PREFIX}/${DBX_CONTAINER_NAME}

echo "Removing old distrobox"
distrobox rm --force ${DBX_CONTAINER_NAME}

echo "Creating new distrobox"
distrobox create \
  --nvidia \
  --init \
  --additional-packages \
    "blas-openblas cmake gcc-fortran git-lfs go imagemagick ninja opencl-nvidia r reflector speedtest-cli vim"
cp -rp $HOME/.ssh ${DBX_CONTAINER_HOME_PREFIX}/${DBX_CONTAINER_NAME}

echo "All the distroboxes:"
distrobox list

echo "Entering ${DBX_CONTAINER_NAME}"
distrobox enter ${DBX_CONTAINER_NAME}
