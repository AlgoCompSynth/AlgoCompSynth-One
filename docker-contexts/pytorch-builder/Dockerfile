FROM "nvcr.io/nvidia/l4t-base:r32.7.1"
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
ENV PYTORCH_VERSION=1.10.0
ENV PATCHFILE=pytorch-1.10-jetpack-4.5.1.patch
COPY clone-pytorch.sh $PATCHFILE $SCRIPTS/
RUN $SCRIPTS/clone-pytorch.sh

# install Mambaforge
COPY mambaforge.sh $SCRIPTS/
RUN $SCRIPTS/mambaforge.sh

# create virtual environment
ENV PYTHON_VERSION=3.10
COPY create-venv.sh $SCRIPTS/
RUN $SCRIPTS/create-venv.sh

# build PyTorch wheel
COPY ram_kilobytes.sh /usr/local/bin/
COPY build-pytorch.sh $SCRIPTS/
RUN $SCRIPTS/build-pytorch.sh

# test install PyTorch wheel
COPY test-install.sh $SCRIPTS/
RUN $SCRIPTS/test-install.sh
