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

FROM "nvcr.io/nvidia/l4t-base:r32.7.1"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base and libraries
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh
COPY deviceQuery.sh $SCRIPTS/
RUN $SCRIPTS/deviceQuery.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

# FluidSynth needs a newer version of CMake
ENV CMAKE_VERSION="3.23.0"
COPY cmake.sh $SCRIPTS/
RUN $SCRIPTS/cmake.sh

# Jetsons don't have ALSA MIDI - install FluidSynth
ENV LIBINSTPATCH_VERSION="1.1.6"
COPY libinstpatch.sh $SCRIPTS/
RUN $SCRIPTS/libinstpatch.sh
ENV FLUIDSYNTH_VERSION="2.2.4"
COPY fluidsynth.sh $SCRIPTS/
RUN $SCRIPTS/fluidsynth.sh

# set up 'synth' account
COPY synth-user.sh $SCRIPTS/
RUN $SCRIPTS/synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
RUN mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

COPY --chown=synth:synth mambaforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

# create environment with cusignal and jupyterlab
ENV CUSIGNAL_VERSION="22.04.00"
ENV CUSIGNAL_TEST="0"
COPY --chown=synth:synth cusignal.sh cusignal_jetson_base.yml $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/cusignal.sh

# R, IRkernel and devtools
COPY --chown=synth:synth R-base.sh base.R $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/R-base.sh

COPY --chown=synth:synth R-audio.sh audio.R $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/R-audio.sh

COPY --chown=synth:synth \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/
