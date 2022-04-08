#! /bin/bash

set -e

sudo nvpmodel -m 8 -d cool
sudo nvpmodel -q
sudo jetson_clocks --fan
sudo jetson_clocks --show
