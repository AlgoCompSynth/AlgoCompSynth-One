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
ENV PACKAGES=$SOURCE_DIR/packages
ENV WORKON_HOME=/root/.virtualenvs
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base and libraries
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh
COPY deviceQuery.sh $SCRIPTS/
RUN $SCRIPTS/deviceQuery.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

# build PyTorch wheel
ENV PYTORCH_VERSION="1.10"
# ENV PYTORCH_VERSION="1.9"
# ENV PYTORCH_VERSION="1.8"
# ENV PYTORCH_VERSION="1.7"
ENV PATCHFILE="pytorch-$PYTORCH_VERSION-jetpack-4.5.1.patch"
ENV PYTHON_VERSION="3.9"
# ENV PYTHON_VERSION="3.8"
# ENV PYTHON_VERSION="3.7"
# Don't use Python 3.6. It will work but NVIDIA have already built those wheels!!
COPY build-pytorch.sh $PATCHFILE pytorch-from-source-requirements.txt $SCRIPTS/
RUN $SCRIPTS/build-pytorch.sh
