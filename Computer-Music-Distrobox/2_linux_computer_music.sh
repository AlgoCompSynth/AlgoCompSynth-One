#! /usr/bin/env bash

set -e

echo "Installing jackd2"
sleep 10
sudo apt-get install -qqy --no-install-recommends jackd2

echo "Adding $USER to the 'audio' group"
sleep 10
sudo usermod -aG audio $USER

echo ""
echo "Installing multimedia-tasks"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  multimedia-tasks \
  > Logs/2_linux_computer_music.log 2>&1

echo "...ambisonics"
/usr/bin/time sudo apt-get install -qqy multimedia-ambisonics > Logs/2_ambisonics.log 2>&1

echo "...csound"
/usr/bin/time sudo apt-get install -qqy multimedia-csound > Logs/2_csound.log 2>&1

echo "...puredata"
/usr/bin/time sudo apt-get install -qqy multimedia-puredata > Logs/2_puredata.log 2>&1

echo "...supercollider"
/usr/bin/time sudo apt-get install -qqy multimedia-supercollider > Logs/2_supercollider.log 2>&1

echo ""
echo "Installing other tools"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  audacity \
  chuck \
  faust \
  ffmpeg \
  ffmpeg-doc \
  flac \
  fluidsynth \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  liblo-dev \
  liblo-tools \
  libsoxr-dev \
  libsox-dev \
  libsox-fmt-all \
  mp3splt \
  musescore-general-soundfont-lossless \
  musescore \
  polyphone \
  sf3convert \
  sonic-pi \
  sonic-pi-samples  \
  sonic-pi-server  \
  sonic-pi-server-doc \
  sox \
  stk \
  stk-doc \
  swami \
  >> Logs/2_linux_computer_music.log 2>&1

echo "Finished"
