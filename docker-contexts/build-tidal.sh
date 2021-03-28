#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd tidal; ../build.sh ; popd
docker images
