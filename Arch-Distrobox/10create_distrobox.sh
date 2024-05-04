#! /usr/bin/env bash

set -e

if [ "$#" -lt "1" ]
then
  echo ""
  echo "Usage: ./10create_distrobox.sh 'container_name' 'container_home_prefix'"
  echo ""
  echo "where 'container_name' is the name of the container to be created and"
  echo "'container_home_prefix' is a sub-path of '\$HOME' where the container's"
  echo "home directory will be created."
  echo ""
  echo "'container_home_prefix' is optional; '\$HOME' will be used if it is"
  echo "missing. For example,"
  echo ""
  echo "./10create_distrobox.sh Arch dbx-homes"
  echo ""
  echo "will create a container named 'Arch' with a home directory of"
  echo "'\$HOME/dbx-homes/Arch'"
  exit
fi

export DBX_CONTAINER_NAME="$1"
if [ "$#" -gt "1" ]
then
  export DBX_CONTAINER_HOME_PREFIX="$HOME/$2"
else
  export DBX_CONTAINER_HOME_PREFIX="$HOME"
fi
export CONTAINER_HOME_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_IMAGE="quay.io/toolbx/arch-toolbox:latest"

echo "DBX_CONTAINER_NAME: $DBX_CONTAINER_NAME"
echo "DBX_CONTAINER_HOME_PREFIX: $DBX_CONTAINER_HOME_PREFIX"
echo "CONTAINER_HOME_DIRECTORY: $CONTAINER_HOME_DIRECTORY"
echo "DBX_CONTAINER_IMAGE: $DBX_CONTAINER_IMAGE"

echo "Creating Distrobox"
distrobox create \
  --nvidia \
  --init \
  --home "$CONTAINER_HOME_DIRECTORY" \
  --additional-packages \
    "systemd base-devel blas-openblas git git-lfs go opencl-nvidia reflector time tree vim"

echo "Current distroboxes"
distrobox list

echo "Entering Distrobox $DBX_CONTAINER_NAME"
distrobox enter ${DBX_CONTAINER_NAME}
