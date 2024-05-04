#! /usr/bin/env bash

set -e

if [ "$#" -lt "1" ]
then
  echo "Using default container name ACS-1"
  export DBX_CONTAINER_NAME="ACS-1"
else
  export DBX_CONTAINER_NAME="$1"
fi

if [ "$#" -lt "2" ]
then
  echo "Using default container home prefix '\$HOME'"
  export DBX_CONTAINER_HOME_PREFIX="$HOME"
else
  export DBX_CONTAINER_HOME_PREFIX="$HOME/$2"
fi

export CONTAINER_HOME_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_IMAGE="quay.io/toolbx/arch-toolbox:latest"

echo "DBX_CONTAINER_NAME: $DBX_CONTAINER_NAME"
echo "DBX_CONTAINER_HOME_PREFIX: $DBX_CONTAINER_HOME_PREFIX"
echo "CONTAINER_HOME_DIRECTORY: $CONTAINER_HOME_DIRECTORY"
echo "DBX_CONTAINER_IMAGE: $DBX_CONTAINER_IMAGE"
echo "Sleeping for 20 seconds - use CTL-C to exit if these are unacceptable"
sleep 20

echo "Creating Distrobox"
distrobox create \
  --nvidia \
  --pull \
  --init \
  --home "$CONTAINER_HOME_DIRECTORY" \
  --additional-packages \
    "systemd base-devel blas-openblas cmake git git-lfs go opencl-nvidia reflector time tree vim"
echo "Current distroboxes"
distrobox list

echo "Entering Distrobox $DBX_CONTAINER_NAME"
distrobox enter ${DBX_CONTAINER_NAME}
