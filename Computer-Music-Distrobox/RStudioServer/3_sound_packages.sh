#! /usr/bin/env bash

set -e

echo "Installing sound R packages - this takes some time"
/usr/bin/time ./sound_packages.R > ../Logs/3_sound_packages.log 2>&1

echo "Finished"
