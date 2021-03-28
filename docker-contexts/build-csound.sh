#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd csound; ../build.sh ; popd
docker images
