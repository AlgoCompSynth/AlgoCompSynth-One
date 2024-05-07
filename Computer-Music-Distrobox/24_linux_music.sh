#! /usr/bin/env bash

echo "Installing Linux music tools"
/usr/bin/time sudo pacman --sync --refresh --needed --noconfirm \
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
  libsoxr \
  mp3splt \
  musescore \
  pd \
  pd-externals \
  pipewire-jack \
  polyphone \
  sc3-plugins \
  soundfont-fluid \
  sox \
  supercollider \
  timidity++ \
  vim-csound \
  > Logs/24_linux_music.log 2>&1

echo "Finished"
