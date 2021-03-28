#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd base; ../build.sh ; popd
docker images
