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

ENV SUPERCOLLIDER_VERSION="Version-3.11.1"
ENV SC3_PLUGINS_VERSION="Version-3.11.1"
COPY supercollider.sh $SCRIPTS/
RUN $SCRIPTS/supercollider.sh

COPY tidal.sh $SCRIPTS
RUN $SCRIPTS/tidal.sh

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
