FROM "ubuntu:bionic"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

ENV CMAKE_VERSION="3.20.0"
ENV SUPERCOLLIDER_TARBALL="https://github.com/supercollider/supercollider/releases/download/Version-3.11.2/SuperCollider-3.11.2-Source.tar.bz2"
ENV SC3_PLUGINS_TARBALL="https://github.com/supercollider/sc3-plugins/releases/download/Version-3.11.1/sc3-plugins-3.11.1-Source.tar.bz2"
COPY supercollider.sh $SCRIPTS/
RUN $SCRIPTS/supercollider.sh

COPY tidal.sh $SCRIPTS/
RUN $SCRIPTS/tidal.sh
