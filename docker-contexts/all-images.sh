#! /bin/bash

set -e

./image.sh base > /tmp/i-base.log 2>&1
for repo in \
  tidal \
  csound \
  chuck
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait

docker images
