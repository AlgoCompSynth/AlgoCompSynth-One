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

FROM "nvcr.io/nvidia/l4t-base:r32.6.1"
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

# Jetsons don't have ALSA MIDI - install FluidSynth
ENV LIBINSTPATCH_VERSION="1.1.6"
COPY libinstpatch.sh $SCRIPTS/
RUN $SCRIPTS/libinstpatch.sh

# FluidSynth needs a newer version of CMake
ENV CMAKE_VERSION="3.22.0"
COPY cmake.sh $SCRIPTS/
RUN $SCRIPTS/cmake.sh
ENV FLUIDSYNTH_VERSION="2.2.4"
COPY fluidsynth.sh $SCRIPTS/
RUN $SCRIPTS/fluidsynth.sh

# Enough packages need Faust to justify system install
ENV FAUST_VERSION="2.37.3"
COPY faust.sh $SCRIPTS/
RUN $SCRIPTS/faust.sh

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

COPY --chown=synth:synth miniforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/miniforge.sh > $SYNTH_LOGS/miniforge.log 2>&1

ENV CUSIGNAL_VERSION="21.10.00"
ENV CUSIGNAL_TEST="0"
COPY --chown=synth:synth cusignal.sh cusignal_jetson_base.yml $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/cusignal.sh

ENV PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
ENV PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
ENV TORCHAUDIO_VERSION="0.10.0"
COPY --chown=synth:synth pytorch.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/pytorch.sh

COPY --chown=synth:synth jupyterlab.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/jupyterlab.sh

COPY --chown=synth:synth R-audio.sh audio.R $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/R-audio.sh

COPY --chown=synth:synth \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/

COPY --chown=synth:synth \
  Installers \
  $SYNTH_HOME/Installers

# set PYTHONPATH so conda environments can see PyTorch and friends
ENV PYTHONPATH=/usr/local/lib/python3.6/dist-packages

# set versions of optional components
ENV CHUCK_VERSION="1.4.1.0"
ENV CSOUND_VERSION="6.16.2"
ENV SUPERCOLLIDER_VERSION="3.12.1"
ENV SC3_PLUGINS_VERSION="3.11.1"
