#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

echo "Creating logfile directory"
export LOGFILES=$HOME/logfiles
mkdir --parents $LOGFILES
rm -f $LOGFILES/base.log

echo "Installing base Linux packages"
echo "Be sure to say 'yes' if asked if you"
echo "want to enable realtime process priority:"
sudo apt-get install -y --no-install-recommends \
  apt-file \
  curl \
  emacs-nox \
  file \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  jack-tools \
  jackd2 \
  jacktrip \
  libsox-fmt-all \
  lynx \
  mlocate \
  sox \
  speedtest-cli \
  time \
  timidity \
  timidity-daemon \
  tree \
  vim-nox \
  wget
echo "Updating 'apt-file' database"
sudo apt-file update
echo "Updating 'locate' database"
sudo updatedb

echo "Installing 'deviceQuery' to '/usr/local/bin'"
pushd /usr/local/cuda/samples/1_Utilities/deviceQuery
  sudo make
  sudo cp deviceQuery /usr/local/bin/
  popd
deviceQuery | tee $LOGFILES/deviceQuery.log

if [ ! -d $HOME/miniconda3 ]
then
  echo "Miniforge not installed - installing it"

  mkdir --parents $HOME/Downloads/Installers
  cd $HOME/Downloads/Installers
  echo "Downloading Miniforge3 installer"
  wget -q \
    https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
  chmod +x Miniforge3-Linux-aarch64.sh
  
  echo "Installing a fresh copy to '$HOME/miniconda3' ..."
  rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
  ./Miniforge3-Linux-aarch64.sh -b -p $HOME/miniconda3 \
    >> $LOGFILES/base.log 2>&1 \
    && rm ./Miniforge3-Linux-aarch64.sh
  
  echo "Initializing conda for 'bash'"
  source $HOME/miniconda3/etc/profile.d/conda.sh
  conda init bash
  conda config --set auto_activate_base false
fi

echo "Updating 'base' Conda environment"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda update --name base --yes --quiet --all \
  >> $LOGFILES/base.log 2>&1

echo "Downloading a test MIDI file"
wget --quiet --no-clobber \
  http://www.piano-midi.de/midis/balakirew/islamei.mid \
  >> $LOGFILES/base.log 2>&1

echo "Converting to a '.wav' file"
timidity -A 35 --output-mode=w --sampling-freq=48000 \
  --output-file=islamei.wav ./islamei.mid \
  >> $LOGFILES/base.log 2>&1

echo "Converting to a '.flac' file"
timidity -A 35 --output-mode=F --sampling-freq=48000 \
  --output-file=islamei.flac ./islamei.mid \
  >> $LOGFILES/base.log 2>&1
