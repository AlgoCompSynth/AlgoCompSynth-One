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

# clone PyTorch source
ENV PYTORCH_VERSION=1.7.1
ENV PATCHFILE=pytorch-1.7.1-jetpack-4.4.1.patch
COPY clone-pytorch.sh $PATCHFILE $SCRIPTS/
RUN $SCRIPTS/clone-pytorch.sh

# install Mambaforge
COPY mambaforge.sh $SCRIPTS/
RUN $SCRIPTS/mambaforge.sh

# create virtual environment
COPY create-venv.sh $SCRIPTS/
RUN $SCRIPTS/create-venv.sh

# build PyTorch wheel
COPY ram_kilobytes.sh /usr/local/bin/
COPY build-pytorch.sh pytorch-from-source-requirements.txt $SCRIPTS/
RUN nice $SCRIPTS/build-pytorch.sh

# test install PyTorch wheel
COPY test-install.sh $SCRIPTS/
RUN $SCRIPTS/test-install.sh
