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
sudo apt-get install -y --no-install-recommends \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  jack-tools \
  jackd2 \
  jacktrip \
  libsox-fmt-all \
  sox \
  timidity \
  timidity-daemon
echo "Downloading a test MIDI file"
wget --quiet --no-clobber http://www.piano-midi.de/midis/balakirew/islamei.mid
echo "Converting to a '.wav' file"
timidity -A 35 --output-mode=w --sampling-freq=48000 --output-file=islamei.wav ./islamei.mid
