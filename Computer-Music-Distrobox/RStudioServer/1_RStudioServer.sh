#! /usr/bin/env bash

set -e

DISTRIBUTOR=`lsb_release -is | grep -v "No LSB modules"`
CODENAME=`lsb_release -cs | grep -v "No LSB modules"`

echo ""
echo "Running on $DISTRIBUTOR $CODENAME"

if [ "$CODENAME" == "bookworm" ]
then
  # https://cran.rstudio.com/bin/linux/debian/#secure-apt
  echo "..getting signing key"
  gpg --keyserver keyserver.ubuntu.com \
    --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
  gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | \
    sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc

  echo "..adding CRAN repository"
  # https://cran.rstudio.com/bin/linux/debian/#debian-bookworm
  sudo cp bookworm.list /etc/apt/sources.list.d/
elif [ "$DISTRIBUTOR" == "Ubuntu" ]
then
  # https://cran.rstudio.com/bin/linux/ubuntu/ 

  # update indices
  sudo apt-get update -qq
  # install two helper packages we need
  sudo apt-get install -qqy --no-install-recommends software-properties-common dirmngr
  # add the signing key (by Michael Rutter) for these repos
  # To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
  # Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
  echo "..getting signing key"
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
  # add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
  echo "..adding CRAN repository"
  sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $CODENAME-cran40/"
else
  echo "..exit -1024 unrecognized distributor / codename"
  exit -1024
fi

echo "Installing R and gdebi-core"
sudo apt-get update -qq
sudo apt-get install -qqy --no-install-recommends \
  gdebi-core \
  r-base \
  r-base-dev \
  > Logs/1_RStudioServer.log 2>&1
echo ""
echo "R --version: `R --version`"
echo ""
echo ""

echo "Setting R profile $HOME/.Rprofile"
cp Rprofile $HOME/.Rprofile
echo ""

echo "Stopping and disabling rstudio-server"
echo "You can ignore error messages"
sudo systemctl disable --now rstudio-server || true

echo ""
echo "Installing RStudio Server"
pushd /tmp
rm -f *.deb

# https://posit.co/download/rstudio-server/
export RSTUDIO_SERVER_PACKAGE="rstudio-server-2024.04.0-735-amd64.deb"
wget --quiet https://download2.rstudio.org/server/jammy/amd64/$RSTUDIO_SERVER_PACKAGE
sudo gdebi -n -q $RSTUDIO_SERVER_PACKAGE

echo ""
echo "Installing Quarto CLI"
export QUARTO_VERSION=1.4.554
wget --quiet https://github.com/quarto-dev/quarto-cli/releases/download/v$QUARTO_VERSION/quarto-$QUARTO_VERSION-linux-amd64.deb
sudo dpkg -i quarto-$QUARTO_VERSION-linux-amd64.deb
popd

echo "Setting password for $USER - RStudio Server needs it"
sudo passwd $USER

echo "Finished!"
