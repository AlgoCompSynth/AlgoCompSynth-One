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
CMD [ "/bin/bash" ]

# install command-line base and libraries
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh
COPY deviceQuery.sh $SCRIPTS/
RUN $SCRIPTS/deviceQuery.sh

# cusignal
COPY cusignal.sh $SCRIPTS/
ENV CUSIGNAL_VERSION="21.08.00"
RUN $SCRIPTS/cusignal.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

# synthesizers
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
  $SYNTH_HOME/Logfiles
COPY --chown=synth:synth \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/
RUN chown -R synth:synth $SYNTH_HOME

RUN ls -lR /usr/local > $LOGS/after.log

USER synth
WORKDIR $SYNTH_HOME
