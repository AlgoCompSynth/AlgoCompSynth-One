#! /bin/bash

set -e

./image.sh xpra > /tmp/i-xpra.log 2>&1
./image.sh base > /tmp/i-base.log 2>&1

for repo in \
  audacity \
  chuck \
  csound-cuda
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait

for repo in \
  rstats-audio \
  tidal
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait
