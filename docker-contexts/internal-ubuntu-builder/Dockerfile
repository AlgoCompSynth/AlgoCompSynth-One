FROM "ubuntu:bionic"
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

# install command-line base
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh

COPY cmake.sh $SCRIPTS/
ENV CMAKE_VERSION="3.20.0"
RUN $SCRIPTS/cmake.sh

ENV XPRA_VERSION="4.1.2"
COPY package-xpra.sh $SCRIPTS/
RUN $SCRIPTS/package-xpra.sh

ENV XPRA_HTML5_VERSION="4.1.2"
COPY package-xpra-html5.sh $SCRIPTS/
RUN $SCRIPTS/package-xpra-html5.sh

COPY llvm.sh $SCRIPTS/
ENV LLVM_VERSION="11.0.1"
RUN $SCRIPTS/llvm.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

COPY fluidsynth.sh $SCRIPTS/
ENV FLUIDSYNTH_VERSION="2.2.0"
RUN $SCRIPTS/fluidsynth.sh

COPY faust.sh $SCRIPTS/
ENV FAUST_VERSION="2.30.5"
RUN $SCRIPTS/faust.sh

COPY chuck.sh $SCRIPTS/
ENV CHUCK_VERSION="1.4.0.1"
RUN $SCRIPTS/chuck.sh

COPY supercollider.sh $SCRIPTS/
ENV SUPERCOLLIDER_VERSION="3.11.2"
ENV SC3_PLUGINS_VERSION="3.11.1"
RUN $SCRIPTS/supercollider.sh

RUN mv \
  $SOURCE_DIR/xpra-html5/dist/xpra-html5-4.1.2-1.deb \
  $SOURCE_DIR/xpra_4.1.2-1_arm64.deb \
  $PACKAGES/

RUN ls -lR /usr/local > $LOGS/after.log
