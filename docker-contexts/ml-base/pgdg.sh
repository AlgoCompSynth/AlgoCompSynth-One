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
rm -f $LOGS/pgdg.log
cd $SOURCE_DIR

echo "Installing PGDG Linux repository"
# https://wiki.postgresql.org/wiki/Apt
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update \
  >> $LOGS/pgdg.log 2>&1
apt-get upgrade -y \
  >> $LOGS/pgdg.log 2>&1
apt-get clean \
  >> $LOGS/pgdg.log 2>&1
