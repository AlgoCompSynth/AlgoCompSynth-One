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

# https://github.com/supercollider/supercollider/wiki/Installing-supercollider-from-source-on-Ubuntu

exit
set -e
rm -f $SYNTH_LOGS/conda-preload.log

source $HOME/miniconda3/etc/profile.d/conda.sh
source $HOME/miniconda3/etc/profile.d/mamba.sh
mamba activate r-reticulate
mamba install --quiet --yes \
  r-bslib \
  r-cachem \
  r-codetools \
  r-colorspace \
  r-commonmark \
  r-doparallel \
  r-dplyr \
  r-farver \
  r-fontawesome \
  r-foreach \
  r-fs \
  r-generics \
  r-ggplot2 \
  r-gtable \
  r-httpuv \
  r-isoband \
  r-iterators \
  r-jquerylib \
  r-labeling \
  r-later \
  r-lattice \
  r-matrix \
  r-mgcv \
  r-mime \
  r-munsell \
  r-mvtnorm \
  r-nlme \
  r-pkgconfig \
  r-plyr \
  r-promises \
  r-purrr \
  r-r6 \
  r-rappdirs \
  r-rcolorbrewer \
  r-reshape2 \
  r-sass \
  r-scales \
  r-shiny \
  r-shinybs \
  r-shinyjs \
  r-sourcetools \
  r-stringi \
  r-stringr \
  r-tibble \
  r-tidyr \
  r-tidyselect \
  r-viridisLite \
  r-withr \
  r-xtable \
  r-zoo \
  >> $SYNTH_LOGS/conda-preload.log 2>&1

echo "Cleanup"
mamba clean --all --yes \
  >> $SYNTH_LOGS/conda-preload.log 2>&1
