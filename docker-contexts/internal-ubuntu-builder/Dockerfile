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

COPY llvm.sh $SCRIPTS/
ENV LLVM_VERSION="11.0.1"
RUN $SCRIPTS/llvm.sh

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

COPY libinstpatch.sh $SCRIPTS/
ENV LIBINSTPATCH_VERSION="1.1.6"
RUN $SCRIPTS/libinstpatch.sh

COPY fluidsynth.sh $SCRIPTS/
ENV FLUIDSYNTH_VERSION="2.2.0"
RUN $SCRIPTS/fluidsynth.sh

COPY faust.sh $SCRIPTS/
ENV FAUST_VERSION="2.30.5"
RUN $SCRIPTS/faust.sh

COPY chuck.sh $SCRIPTS/
ENV CHUCK_VERSION="1.4.0.1"
RUN $SCRIPTS/chuck.sh

# Pandoc and R
ENV PANDOC_VERSION="2.12"
COPY upstream-pandoc.sh $SCRIPTS/
RUN $SCRIPTS/upstream-pandoc.sh

ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=5
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY R.conf /etc/ld.so.conf.d/R.conf
COPY r-from-source.sh $SCRIPTS/
RUN $SCRIPTS/r-from-source.sh
COPY audio.sh audio.R pgdg.list $SCRIPTS/
RUN $SCRIPTS/audio.sh

RUN ls -lR /usr/local > $LOGS/after.log
