FROM "nvcr.io/nvidia/l4t-ml:r32.5.0-py3"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

RUN echo "set bg=dark" >> /root/.vimrc

COPY base.sh $SCRIPTS
RUN $SCRIPTS/base.sh

ENV CMAKE_VERSION="3.20.0"
COPY cmake.sh $SCRIPTS
RUN $SCRIPTS/cmake.sh

ENV FLUIDSYNTH_VERSION="v2.1.8"
COPY fluidsynth.sh $SCRIPTS
RUN $SCRIPTS/fluidsynth.sh

# Pandoc
ENV PANDOC_VERSION="2.12"
COPY upstream-pandoc.sh $SCRIPTS/
RUN $SCRIPTS/upstream-pandoc.sh

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=4
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY R.conf /etc/ld.so.conf.d/R.conf
COPY r-from-source.sh $SCRIPTS/
RUN $SCRIPTS/r-from-source.sh

# PGDG repository
COPY pgdg.list /etc/apt/sources.list.d/pgdg.list
COPY pgdg.sh $SCRIPTS/
RUN $SCRIPTS/pgdg.sh

# SymPy
COPY sympy.sh $SCRIPTS/
RUN $SCRIPTS/sympy.sh

# cuSignal
COPY cusignal.sh $SCRIPTS/
RUN $SCRIPTS/cusignal.sh

# set up 'synth' account
COPY synth-user.sh $SCRIPTS/
RUN $SCRIPTS/synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

ENV SYNTH_HOME=/home/synth
COPY --chown=synth:synth Desktop $SYNTH_HOME/Desktop
COPY --chown=synth:synth Music $SYNTH_HOME/Music
COPY --chown=synth:synth Projects $SYNTH_HOME/Projects
COPY --chown=synth:synth Scripts $SYNTH_HOME/Scripts
COPY --chown=synth:synth Rprofile $SYNTH_HOME/.Rprofile
COPY --chown=synth:synth Logfiles $SYNTH_HOME/Logfiles
RUN echo "set bg=dark" >> $SYNTH_HOME/.vimrc
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

# R packages
RUN $SYNTH_HOME/Scripts/r-packages.sh
