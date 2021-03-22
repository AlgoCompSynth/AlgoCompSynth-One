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

# http://tedfelix.com/linux/linux-midi.html
echo "Installing L4T audio plumbing packages"
echo "Be sure to say 'yes' when it asks if you want to enable realtime process priority:"
sudo apt-get install -y \
  alsa-tools \
  bluetooth \
  bluez \
  bluez-tools \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  jackd2 \
  jack-tools \
  jacktrip \
  libasound2-dev \
  libbluetooth-dev \
  libcamera-calibration-parsers-dev \
  libcamera-info-manager-dev \
  libdbus-1-dev \
  libfdk-aac-dev \
  libjack-jackd2-dev \
  libncurses5-dev \
  libsbc-dev \
  libsdl2-dev \
  libsndfile1-dev \
  libsox-fmt-all \
  libsystemd-dev \
  libudev-dev \
  libvulkan-dev \
  mp3splt \
  ofono \
  pavucontrol \
  pavumeter \
  pmidi \
  pulseaudio \
  pulseaudio-dlna \
  pulseaudio-equalizer \
  pulseaudio-module-bluetooth \
  pulseaudio-module-gconf \
  pulseaudio-module-jack \
  pulseaudio-module-lirc \
  pulseaudio-module-raop \
  pulseaudio-module-zeroconf \
  pulseaudio-utils \
  pulsemixer \
  rfkill \
  sox \
  timidity
echo "Adding '${USER}' to the 'bluetooth' and 'pulse' groups"
sudo usermod -aG pulse ${USER}
sudo usermod -aG bluetooth ${USER}
exit

source $HOME/miniconda3/etc/profile.d/conda.sh

echo "Creating fresh 'pipewire' conda environment"
conda env remove --name pipewire --yes
conda create --name pipewire --quiet --yes \
  meson \
  ninja
conda activate pipewire
export MESON_OPTIONS_PATCH=$PWD/meson_options.txt
mkdir --parents $CONDA_PREFIX/src
pushd $CONDA_PREFIX/src
  rm -fr pipewire*
  export PIPEWIRE_VERSION="0.3.24"

  echo "Cloning 'pipewire' repo"
  git clone https://gitlab.freedesktop.org/pipewire/pipewire.git
  cd pipewire
  git checkout $PIPEWIRE_VERSION

  echo "Disabling 'alsa' interfaces - L4T alsa libraries are too old"
  diff $MESON_OPTIONS_PATCH meson_options.txt || true
  cp $MESON_OPTIONS_PATCH meson_options.txt

  echo "Building 'pipewire'"
  meson setup build
  meson configure build
  meson configure -Dprefix=$CONDA_PREFIX
  ninja -C build
  popd
