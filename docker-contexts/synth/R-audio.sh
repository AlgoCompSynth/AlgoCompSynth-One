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
rm -f $SYNTH_LOGS/R-audio.log

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate
export PKG_CONFIG_PATH=$HOME/miniconda3/envs/r-reticulate/lib/pkgconfig

echo "Installing conda dependencies"
/usr/bin/time conda install --quiet --yes \
  fftw \
  portaudio \
  r-Matrix \
  r-R6 \
  r-RCurl \
  r-bitops \
  r-brio \
  r-bslib \
  r-cachem \
  r-callr \
  r-cluster \
  r-commonmark \
  r-desc \
  r-diffobj \
  r-fontawesome \
  r-fs \
  r-highr \
  r-httpuv \
  r-ineq \
  r-jquerylib \
  r-knitr \
  r-later \
  r-lattice \
  r-mgcv \
  r-mime \
  r-moments \
  r-mvtnorm \
  r-nlme \
  r-pbapply \
  r-permute \
  r-pkgconfig \
  r-pkgload \
  r-plyr \
  r-pracma \
  r-praise \
  r-processx \
  r-promises \
  r-ps \
  r-rappdirs \
  r-rematch2 \
  r-reshape2 \
  r-rjson \
  r-rprojroot \
  r-rstudioapi \
  r-sass \
  r-sf \
  r-shiny \
  r-shinyBS \
  r-shinyjs \
  r-sourcetools \
  r-stringi \
  r-stringr \
  r-testthat \
  r-tibble \
  r-units \
  r-waldo \
  r-withr \
  r-xfun \
  r-xtable \
  r-yaml \
  r-zoo \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Installing R packages"
/usr/bin/time $SYNTH_SCRIPTS/audio.R \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Finished"
