FROM "ubuntu:bionic"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

RUN echo "set bg=dark" >> /root/.vimrc
COPY scripts/10base.sh $SCRIPTS/
RUN $SCRIPTS/10base.sh || true

# install libmusicxml early because it takes 50 minutes
ENV LIBMUSICXML_VERSION="v3.18"
COPY scripts/15libmusicxml.sh $SCRIPTS/
RUN $SCRIPTS/15libmusicxml.sh || true

ENV SUPERCOLLIDER_VERSION="Version-3.11.1"
ENV SC3_PLUGINS_VERSION="Version-3.11.1"
COPY scripts/20supercollider.sh $SCRIPTS/
RUN $SCRIPTS/20supercollider.sh || true

ENV SONIC_PI_VERSION="v3.3.1"
COPY scripts/21sonic-pi.sh $SCRIPTS/
RUN $SCRIPTS/21sonic-pi.sh || true

ENV FLUIDSYNTH_VERSION="v2.1.8"
COPY scripts/22fluidsynth.sh $SCRIPTS
RUN $SCRIPTS/22fluidsynth.sh || true

ENV FAUST_VERSION="2.30.5"
COPY scripts/23faust.sh $SCRIPTS
RUN $SCRIPTS/23faust.sh || true

ENV PD_VERSION="0.51-4"
COPY scripts/24pure-data.sh $SCRIPTS
RUN $SCRIPTS/24pure-data.sh || true

ENV CSOUND_VERSION="6.15.0"
COPY scripts/25csound.sh $SCRIPTS
RUN $SCRIPTS/25csound.sh || true

ENV CHUCK_VERSION="1.4.0.1"
COPY scripts/26chuck.sh $SCRIPTS
RUN $SCRIPTS/26chuck.sh || true

ENV XPRA_VERSION="v4.1.1"
COPY scripts/27xpra.sh $SCRIPTS
RUN $SCRIPTS/27xpra.sh || true

COPY scripts/28tidal.sh $SCRIPTS
RUN $SCRIPTS/28tidal.sh || true
