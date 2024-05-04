#! /usr/bin/env bash

echo "Installing Linux music tools"
yay --sync --refresh --needed --noconfirm \
  audacity \
  audacity-docs \
  chuck \
  csound-doc \
  csound-plugins \
  csoundqt \
  csound \
  faust \
  ffmpeg \
  flac \
  fluidsynth \
  freepats-general-midi \
  ft2-clone \
  furnace \
  goattracker \
  klystrack-plus \
  libopenmpt \
  libsoxr \
  milkytracker \
  musescore \
  pd \
  pd-externals \
  pipewire-jack \
  polyphone \
  pt2-clone \
  sc3-plugins \
  schismtracker \
  soundfont-fluid \
  sox \
  supercollider \
  timidity++ \
  vim-csound

echo "Finished"
