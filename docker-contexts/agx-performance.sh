#! /bin/bash

set -e

sudo nvpmodel -q
sudo nvpmodel -m 0 -d cool
sudo nvpmodel -q
sudo jetson_clocks --show
sudo jetson_clocks --fan
sudo jetson_clocks --show
