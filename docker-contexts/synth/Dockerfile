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

FROM "nvcr.io/nvidia/l4t-ml:r32.6.1-py3"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN ls -lR /usr/local > $LOGS/before.log
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base and libraries
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh
COPY install-libraries.sh pgdg.list $SCRIPTS/
#RUN $SCRIPTS/install-libraries.sh
COPY deviceQuery.sh $SCRIPTS/
RUN $SCRIPTS/deviceQuery.sh

COPY cmake.sh $SCRIPTS/
ENV CMAKE_VERSION="3.21.2"
RUN $SCRIPTS/cmake.sh

COPY llvm.sh $SCRIPTS/
ENV LLVM_VERSION="12.0.1"
RUN $SCRIPTS/llvm.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

COPY libinstpatch.sh $SCRIPTS/
ENV LIBINSTPATCH_VERSION="1.1.6"
RUN $SCRIPTS/libinstpatch.sh

COPY fluidsynth.sh $SCRIPTS/
ENV FLUIDSYNTH_VERSION="2.2.3"
RUN $SCRIPTS/fluidsynth.sh

COPY faust.sh $SCRIPTS/
ENV FAUST_VERSION="2.33.1"
RUN $SCRIPTS/faust.sh

COPY chuck.sh $SCRIPTS/
ENV CHUCK_VERSION="1.4.1.0"
RUN $SCRIPTS/chuck.sh

COPY csound.sh $SCRIPTS/
ENV CSOUND_VERSION="6.16.2"
RUN $SCRIPTS/csound.sh

# set up 'synth' account
COPY synth-user.sh $SCRIPTS/
RUN $SCRIPTS/synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

ENV SYNTH_HOME=/home/synth
RUN mkdir --parents \
  $SYNTH_HOME/Scripts \
  $SYNTH_HOME/Downloads/Installers \
  $SYNTH_HOME/Logfiles
COPY --chown=synth:synth \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/
COPY --chown=synth:synth Rprofile $SYNTH_HOME/.Rprofile
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

# Miniforge
COPY --chown=synth:synth miniforge.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/miniforge.sh

# cusignal
COPY --chown=synth:synth cusignal.sh $SYNTH_HOME/Scripts/
ENV CUSIGNAL_VERSION="21.08.00"
RUN $SYNTH_HOME/Scripts/cusignal.sh

CMD [ "/bin/bash" ]
