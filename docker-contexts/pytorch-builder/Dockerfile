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
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN chmod a+rwx $PACKAGES
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base and libraries
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh
COPY deviceQuery.sh $SCRIPTS/
RUN $SCRIPTS/deviceQuery.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

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

# install mambaforge
COPY --chown=synth:synth mambaforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

# clone PyTorch source
# Versions are the newest where everything builds.
# Torchaudio 0.10.0 doesn't build with PyTorch 1.10.0
# so we drop back to 0.9.0 / 1.9.0.
# The newest supported Python version is 3.9, which is
# also the default for Mambaforge.
# See https://github.com/pytorch/audio
ENV PYTHON_VERSION=3.9
ENV PYTORCH_VERSION=1.9.0
ENV TORCHAUDIO_VERSION=0.9.0
ENV PATCHFILE=pytorch-1.9-jetpack-4.5.1.patch
COPY --chown=synth:synth clone-pytorch.sh $PATCHFILE $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/clone-pytorch.sh

# create virtual environment
COPY --chown=synth:synth create-venv.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/create-venv.sh

# build PyTorch wheel
COPY --chown=synth:synth build-pytorch.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/build-pytorch.sh

# test install PyTorch wheel
COPY --chown=synth:synth test-install.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/test-install.sh
