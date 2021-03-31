FROM "ubuntu:bionic"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

ENV CHUCK_VERSION="1.4.0.1"
COPY chuck.sh $SCRIPTS
RUN $SCRIPTS/chuck.sh
