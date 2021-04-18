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

#! /bin/bash

set -e

# The Nano only has 4 GB of RAM. As a result, some builds swamp the available
# RAM and multi-job makes / Ninja builds are problematic - they swap and the
# system appears unresponsive, or the out-of-memory killer crashes them.
#
# This script returns the installed RAM in kilobytes. Other scripts can
# use it to adjust build job limits accordingly.
echo `grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'`
