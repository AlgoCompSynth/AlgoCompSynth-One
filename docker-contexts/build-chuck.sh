#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"
pushd chuck; ../build.sh ; popd
docker images
