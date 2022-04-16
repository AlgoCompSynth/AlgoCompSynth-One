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

ENV PYTHON_VERSION="3.6" # NVIDIA PyTorch wheels require this
ENV R_BASE_VERSION="4.0.2" # Newer versions break torchaudio for some reason

ENV CUSIGNAL_VERSION="22.04.00" # newest version
ENV CUSIGNAL_TEST="0" # Testing takes too long

# newest PyTorch version from NVIDIA
ENV PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
ENV PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
ENV TORCHAUDIO_VERSION="0.10.0" # matches PyTorch version

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks

# set up 'synth' account
COPY synth-user.sh /
RUN /synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

# make virtual desktop
COPY --chown=synth:synth \
  build-r-reticulate.sh \
  Home \
  $SYNTH_HOME/

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

RUN $SYNTH_HOME/build-r-reticulate.sh
