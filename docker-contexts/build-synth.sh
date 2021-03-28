#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd synth; ../build.sh ; popd
sudo docker images
