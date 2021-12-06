#! /bin/bash

set -e

docker run --interactive --tty --network host algocompsynth/synth:latest /bin/bash
