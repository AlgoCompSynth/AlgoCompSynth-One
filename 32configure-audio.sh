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
echo "Installing packages"
echo "Be sure to say 'yes' when it asks if you want to enable realtime process priority:"
sudo apt-get install -y \
  alsa-tools \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  jackd2 \
  jack-tools \
  jacktrip \
  libsox-fmt-all \
  mp3splt \
  pmidi \
  sox \
  timidity

# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/hw_setup.html#wwpID0E0DN0HA
echo "Enabling Bluetooth audio"
sudo sed --in-place=.bak --expression="s;-d .*$;-d;" /lib/systemd/system/bluetooth.service.d/nv-bluetooth-service.conf
echo  "'/lib/systemd/system/bluetooth.service.d/nv-bluetooth-service.conf' is now"
cat /lib/systemd/system/bluetooth.service.d/nv-bluetooth-service.conf
echo "Rebooting"
sudo systemctl reboot
