#! /usr/bin/env bash

set -e

echo "Getting signing key"
# https://cran.rstudio.com/bin/linux/debian/#secure-apt
gpg --keyserver keyserver.ubuntu.com \
  --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | \
  sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc

echo "Adding CRAN repository"
# https://cran.rstudio.com/bin/linux/debian/#debian-bookworm
sudo cp bookworm.list /etc/apt/sources.list.d/
sudo apt-get update -qq

echo "Installing R and gdebi-core"
sudo apt-get install -qqy --no-install-recommends \
  gdebi-core \
  r-base \
  r-base-dev \
  > ../Logs/1_RStudioServer.log 2>&1
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
