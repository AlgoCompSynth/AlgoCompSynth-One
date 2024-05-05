#! /usr/bin/env bash

set -e

echo "Installing developer packages - this takes some time"
/usr/bin/time ./devel_packages.R > devel_packages.log 2>&1

echo "Installing sound packages - this takes some time"
/usr/bin/time ./sound_packages.R > sound_packages.log 2>&1

echo "Finished"
