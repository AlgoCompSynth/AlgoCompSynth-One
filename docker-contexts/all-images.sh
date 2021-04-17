#! /bin/bash

set -e

./image.sh internal-ubuntu-builder > /tmp/i-internal-ubuntu-builder.log 2>&1
./image.sh synth > /tmp/i-synth.log 2>&1
