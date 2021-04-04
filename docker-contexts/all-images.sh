#! /bin/bash

set -e

for repo in \
  base \
  xpra \
  csound-cuda
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait

for repo in \
  chuck \
  rstats-audio \
  tidal
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait
