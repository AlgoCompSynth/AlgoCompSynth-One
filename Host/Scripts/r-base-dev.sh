#! /bin/bash

set -e

# https://cran.r-project.org/bin/linux/ubuntu/

# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "Adding signing key"
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
echo "Adding R 4.0 repository"
sudo cp $SYNTH_SCRIPTS/CRAN.focal.list /etc/apt/sources.list.d/

echo "Adding CRAN package repository"
sudo cp $SYNTH_SCRIPTS/c2d4u_team-ubuntu-c2d4u4_0_-focal.list /etc/apt/sources.list.d/

echo "Updating cache"
sudo apt-get update -qq

echo "Finished!"
