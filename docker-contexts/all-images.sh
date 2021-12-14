#! /bin/bash

set -e

nice ./image.sh pytorch-builder > /tmp/i-pytorch-builder.log 2>&1
nice ./image.sh synth > /tmp/i-synth.log 2>&1
