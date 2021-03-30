FROM "ubuntu:bionic"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

ENV FAUST_VERSION="2.30.5"
ENV CMAKE_VERSION="3.20.0"
COPY faust.sh $SCRIPTS/
RUN $SCRIPTS/faust.sh

ENV FLUIDSYNTH_VERSION="2.1.8"
COPY fluidsynth.sh $SCRIPTS
RUN $SCRIPTS/fluidsynth.sh

ENV CSOUND_VERSION="6.15.0"
COPY csound.sh $SCRIPTS/
RUN $SCRIPTS/csound.sh
