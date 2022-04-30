#! /bin/bash

set -e

echo "Defining environment variables"
source ../jetpack-envars.sh
export REPO=$SYNTH_REPO

echo "Pushing $REPO"
/usr/bin/time docker push \
  $REGISTRY/$ACCOUNT/$REPO:$IMAGE_TAG
