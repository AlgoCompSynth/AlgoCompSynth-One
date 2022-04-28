#! /bin/bash

set -e

echo "Before nvpmodel"
sudo nvpmodel --query
sudo nvpmodel --mode 2

echo "After nvpmodel"
sudo nvpmodel --query

echo "Before jetson_clocks"
sudo jetson_clocks --show
sudo jetson_clocks --fan

echo "After jetson_clocks"
sudo jetson_clocks --show
