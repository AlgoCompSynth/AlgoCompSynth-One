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
  fftw-openmpi \
  flac \
  fluidsynth \
  freepats-general-midi \
  imagemagick \
  intel-compute-runtime \
  intel-media-driver \
  liblo \
  libsoxr \
  libvdpau-va-gl \
  mesa-vdpau \
  mp3splt \
  musescore \
  nvtop \
  openmpi \
  openmpi-docs \
  pd \
  pd-externals \
  pipewire-docs \
  pipewire-jack \
  polyphone \
  realtime-privileges \
  rtmidi \
  rtmidi-docs \
  sc3-plugins \
  soundfont-fluid \
  sox \
  stk \
  stk-docs \
  supercollider \
  timidity++ \
  vdpauinfo \
  vim-csound \
  > Logs/24_linux_music.log 2>&1

echo "Adding $USER to the realtime group"
sudo usermod --append --groups realtime $USER
echo "Finished"
