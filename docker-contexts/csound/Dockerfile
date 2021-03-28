FROM "nvcr.io/nvidia/l4t-base:r32.5.0"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

RUN echo "set bg=dark" >> /root/.vimrc

ENV LIBMUSICXML_VERSION="v3.18"
COPY libmusicxml.sh $SCRIPTS/
RUN $SCRIPTS/libmusicxml.sh

ENV FLUIDSYNTH_VERSION="v2.1.8"
COPY fluidsynth.sh $SCRIPTS
RUN $SCRIPTS/fluidsynth.sh

ENV FAUST_VERSION="2.30.5"
COPY faust.sh $SCRIPTS
RUN $SCRIPTS/faust.sh

ENV CSOUND_VERSION="6.15.0"
COPY csound.sh $SCRIPTS
RUN $SCRIPTS/csound.sh

# set up 'synth' account
COPY synth-user.sh $SCRIPTS/
RUN $SCRIPTS/synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

ENV SYNTH_HOME=/home/synth
ENV PROJECT_HOME=$SYNTH_HOME/Projects
RUN mkdir --parents $PROJECT_HOME
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
