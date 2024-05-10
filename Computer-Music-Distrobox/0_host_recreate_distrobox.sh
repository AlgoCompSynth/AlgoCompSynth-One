#! /usr/bin/env bash

set -e

echo "There are two COMPUTE_MODE settings: CUDA for an NVIDIA"
echo "GPU and CPU for any other system. CUDA is the default."
echo ""
echo "To select CPU mode, enter any non-empty string, To stay"
echo "with the default CUDA, simply press 'Enter'."
read -p "COMPUTE_MODE?"

if [ "${#REPLY}" -gt "0" ]
then
  echo "..Setting COMPUTE_MODE to CPU"
  export COMPUTE_MODE=CPU
else
  echo "..Setting COMPUTE_MODE to CUDA"
  export COMPUTE_MODE=CUDA
fi
echo "\$COMPUTE_MODE: $COMPUTE_MODE"

echo "Creating distroboxes"
distrobox assemble create --replace --file distrobox-$COMPUTE_MODE.ini

echo "Finished"
