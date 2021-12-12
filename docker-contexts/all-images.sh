#! /bin/bash

set -e

./image.sh synth > /tmp/i-synth.log 2>&1
./image.sh pytorch-builder > /tmp/i-pytorch-builder.log 2>&1
