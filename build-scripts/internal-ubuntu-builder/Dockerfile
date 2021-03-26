FROM "ubuntu:bionic"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

ENV CHUCK_VERSION="1.4.0.1"
ENV CSOUND_VERSION="6.15.0"
ENV FAUST_VERSION="2.30.5"
ENV FLUIDSYNTH_VERSION="2.1.8"
ENV LIBMUSICXML_VERSION="v3.18"
ENV SC3_PLUGINS_VERSION="Version-3.11.1"
ENV SUPERCOLLIDER_VERSION="Version-3.11.1"
ENV SONIC_PI_VERSION="v3.3.1"

WORKDIR $SOURCE_DIR

RUN echo "set bg=dark" >> /root/.vimrc
COPY scripts/10base.sh $SCRIPTS/
RUN $SCRIPTS/10base.sh

# install libmusicxml early because it takes 50 minutes
COPY scripts/15libmusicxml.sh $SCRIPTS/
RUN $SCRIPTS/15libmusicxml.sh

COPY scripts/20supercollider.sh $SCRIPTS/
RUN $SCRIPTS/20supercollider.sh

COPY scripts/21sonic-pi.sh $SCRIPTS/
#RUN $SCRIPTS/21sonic-pi.sh

COPY scripts/22fluidsynth.sh $SCRIPTS
ENV FLUIDSYNTH_VERSION="v2.1.8"
RUN $SCRIPTS/22fluidsynth.sh

COPY scripts/23faust.sh $SCRIPTS
ENV FAUST_VERSION="2.30.5"
RUN $SCRIPTS/23faust.sh

COPY scripts/24csound.sh $SCRIPTS
ENV CSOUND_VERSION="6.15.0"
#RUN $SCRIPTS/24csound.sh
