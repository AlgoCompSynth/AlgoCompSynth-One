#! /bin/bash

set -e

echo "Before nvpmodel"
sudo nvpmodel -q
sudo nvpmodel -m 8 -d cool

echo "After nvpmodel"
sudo nvpmodel -q

echo "Before jetson_clocks"
sudo jetson_clocks --show
sudo jetson_clocks --fan

echo "After jetson_clocks"
sudo jetson_clocks --show
