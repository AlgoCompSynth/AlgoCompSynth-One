#! /usr/bin/env Rscript

# Copyright (C) 2022 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
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

# reference 
#@book{sueur2018sound,
#  title={Sound analysis and synthesis with R},
#  author={Sueur, J{\'e}r{\^o}me and others},
#  year={2018},
#  publisher={Springer}
#}

options(warn=2)
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "audio",
  "monitoR",
  "music",
  "NatureSounds",
  "phonTools",
  "remotes",
  "reticulate",
  "Rraven",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tabr",
  "tuneR",
  "warbleR"
), repos = "https://cloud.r-project.org/")
warnings()
