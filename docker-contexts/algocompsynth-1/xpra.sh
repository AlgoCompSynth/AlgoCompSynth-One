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
rm -f $LOGS/xpra.log
cd $SOURCE_DIR

#echo "Installing dependencies"
#apt-get install -y --no-install-recommends \
  #cython3 \
  #libx264-dev \
  #libvpx-dev \
  #python3-cups \
  #python3-opengl \
  #>> $LOGS/xpra.log 2>&1
    #brotli \
    #cups-common \
    #cups-filters \
    #cups-pdf \
    #cython3 \
    #debhelper \
    #devscripts \
    #fakeroot \
    #gnome-backgrounds \
    #gstreamer1.0-alsa \
    #gstreamer1.0-plugins-base \
    #gstreamer1.0-plugins-good \
    #gstreamer1.0-plugins-ugly \
    #gstreamer1.0-pulseaudio \
    #keyboard-configuration \
    #libavcodec-dev \
    #libavformat-dev \
    #libgtk-3-dev \
    #libjs-jquery \
    #libjs-jquery-ui \
    #libpam-dev \
    #libswscale-dev \
    #libsystemd-dev \
    #libturbojpeg-dev \
    #libvpx-dev \
    #libwebp-dev \
    #libx11-dev \
    #libx264-dev \
    #libxcomposite-dev \
    #libxdamage-dev \
    #libxkbfile-dev \
    #libxtst-dev \
    #lintian \
    #openssh-client \
    #pandoc \
    #python3-cairo-dev \
    #python3-cryptography \
    #python3-cups \
    #python3-dbus \
    #python3-dev \
    #python3-gi-cairo \
    #python3-gssapi \
    #python3-kerberos \
    #python3-lz4 \
    #python3-netifaces \
    #python3-numpy \
    #python3-opencv \
    #python3-opengl \
    #python3-paramiko \
    #python3-pil \
    #python3-pyinotify \
    #python3-rencode \
    #python3-setproctitle \
    #python3-xdg \
    #python3-yaml \
    #python-all-dev \
    #python-gi-dev \
    #quilt \
    #sshpass \
    #uglifyjs \
    #x11-xkb-utils \
    #xauth \
    #xserver-xorg-dev \
    #xserver-xorg-video-dummy \
    #xutils-dev \
    #xvfb \
    #yasm \

echo "Cloning xpra"
rm -fr xpra
git clone https://github.com/Xpra-org/xpra \
  >> $LOGS/xpra.log 2>&1

echo "Checking out v$XPRA_VERSION"
pushd xpra

  git checkout v$XPRA_VERSION \
    >> $LOGS/xpra.log 2>&1

  echo "Installing xpra"
  python3 ./setup.py install \
    >> $LOGS/xpra.log 2>&1
  popd
