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
rm -f $SYNTH_LOGS/jupyterlab.log

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate

echo "Installing 'jupyterlab' and 'r-irkernel'"
/usr/bin/time conda install --yes --quiet jupyterlab r-irkernel \
  >> $SYNTH_LOGS/jupyterlab.log 2>&1

echo "Activating R kernel"
R -e "IRkernel::installspec()" \
  >> $SYNTH_LOGS/jupyterlab.log 2>&1

echo "Cleanup"
conda clean --all --yes \
  >> $SYNTH_LOGS/jupyterlab.log 2>&1