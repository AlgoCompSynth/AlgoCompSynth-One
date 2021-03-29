#! /bin/bash

set -e

for repo in \
  base \
  ml-base
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait

for repo in \
  csound \
  chuck
do
  ./image.sh $repo > /tmp/i-$repo.log 2>&1 &
done
wait

docker images
