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

mkdir --parents $HOME/Notebooks
cd $HOME

echo "Activating 'r-reticulate'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate

echo "Generating Jupyter configuration file"
jupyter notebook --generate-config -y

echo "Enter the same strong password twice"
jupyter server password

echo "If running remotely, browse to port 8888 on this Jetson host instead of 'localhost'"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
