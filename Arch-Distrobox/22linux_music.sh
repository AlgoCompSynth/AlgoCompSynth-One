#! /usr/bin/env bash

echo "Installing Linux music tools"
yay --sync --refresh --needed --noconfirm \
  chuck \
  csound-doc \
  csound-plugins \
  csoundqt \
  csound \
  faust \
  ffmpeg \
  flac \
  libsoxr \
  pd \
  pd-externals \
  pipewire-jack \
  sc3-plugins \
  sox \
  supercollider \
  vim-csound

echo "Finished"
