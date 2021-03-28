#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="algocompsynth"

for repo in \
  internal-ubuntu-builder \
  synth
do
  pushd $repo; ../build.sh ; popd
done

docker images
