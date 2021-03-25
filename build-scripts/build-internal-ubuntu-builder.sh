#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd internal-ubuntu-builder; ../build.sh ; popd
docker images
