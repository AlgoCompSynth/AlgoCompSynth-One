#! /usr/bin/env bash

set -e

echo "Creating distroboxes"
distrobox assemble create --replace

echo "Finished"
