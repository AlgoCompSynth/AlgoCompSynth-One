#! /usr/bin/env bash

set -e

echo "Installing developer R packages - this takes some time"
/usr/bin/time ./devel_packages.R > ../Logs/2_developer_packages.log 2>&1

echo "Finished"
