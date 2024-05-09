#! /usr/bin/env bash

echo "Installing Linux music tools"
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
  multimedia-ambisonics \
  multimedia-csound \
  multimedia-puredata \
  multimedia-supercollider \
  musescore-general-soundfont-lossless \
  musescore \
  polyphone \
  sf3convert \
  sox \
  stk \
  stk-doc \
  swami \
  > Logs/2_linux_music.log 2>&1

echo "Finished"
