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

set -e
rm -f $SYNTH_LOGS/conda-preload.log

source $HOME/miniconda3/etc/profile.d/conda.sh
source $HOME/miniconda3/etc/profile.d/mamba.sh
mamba activate r-reticulate
mamba install --quiet --yes \
  r-askpass \
  r-bitops \
  r-brew \
  r-brio \
  r-bslib \
  r-cachem \
  r-callr \
  r-clipr \
  r-cluster \
  r-codetools \
  r-colorspace \
  r-commonmark \
  r-cpp11 \
  r-credentials \
  r-curl \
  r-desc \
  r-diffobj \
  r-doParallel \
  r-dplyr \
  r-farver \
  r-fontawesome \
  r-foreach \
  r-fs \
  r-generics \
  r-ggplot2 \
  r-gh \
  r-gitcreds \
  r-gtable \
  r-here \
  r-highr \
  r-httpuv \
  r-httr \
  r-ineq \
  r-ini \
  r-isoband \
  r-iterators \
  r-jquerylib \
  r-knitr \
  r-labeling \
  r-later \
  r-lattice \
  r-magrittr \
  r-MASS \
  r-Matrix \
  r-memoise \
  r-mgcv \
  r-mime \
  r-moments \
  r-munsell \
  r-mvtnorm \
  r-nlme \
  r-openssl \
  r-pbapply \
  r-permute \
  r-pkgbuild \
  r-pkgconfig \
  r-pkgload \
  r-plyr \
  r-png \
  r-pracma \
  r-praise \
  r-prettyunits \
  r-processx \
  r-promises \
  r-proxy \
  r-ps \
  r-purrr \
  r-R6 \
  r-rappdirs \
  r-rcmdcheck \
  r-RColorBrewer \
  r-Rcpp \
  r-RcppTOML \
  r-RCurl \
  r-rematch2 \
  r-reshape2 \
  r-rjson \
  r-roxygen2 \
  r-rprojroot \
  r-rstudioapi \
  r-rversions \
  r-sass \
  r-scales \
  r-sessioninfo \
  r-shiny \
  r-shinyBS \
  r-shinyjs \
  r-sourcetools \
  r-stringi \
  r-stringr \
  r-sys \
  r-testthat \
  r-tibble \
  r-tidyr \
  r-tidyselect \
  r-usethis \
  r-viridisLite \
  r-waldo \
  r-whisker \
  r-withr \
  r-xfun \
  r-xml2 \
  r-xopen \
  r-xtable \
  r-yaml \
  r-zip \
  r-zoo
  >> $SYNTH_LOGS/conda-preload.log 2>&1

echo "Cleanup"
mamba clean --tarballs --yes \
  >> $SYNTH_LOGS/conda-preload.log 2>&1
