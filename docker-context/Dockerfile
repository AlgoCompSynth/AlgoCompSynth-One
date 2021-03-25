FROM "nvcr.io/nvidia/l4t-ml:r32.5.0-py3"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

ENV CUSIGNAL_VERSION=v0.18.0
ENV CHUCK_VERSION=1.4.0.1
ENV CSOUND_VERSION=6.15.0
ENV FAUST_VERSION=2.30.5
ENV FLUIDSYNTH_VERSION=2.1.8
ENV LIBMUSICXML_VERSION=3.18
ENV SC3_PLUGINS_VERSION="Version-3.11.1"
ENV SUPERCOLLIDER_VERSION="Version-3.11.1"

WORKDIR $SOURCE_DIR

COPY cusignal.sh $SOURCE_DIR
RUN $SOURCE_DIR/cusignal.sh
RUN echo "set bg=dark" >> /root/.vimrc
COPY scripts $SCRIPTS
RUN $SCRIPTS/20supercollider.sh
RUN $SCRIPTS/40synth-user.sh

# enable passwordless sudo for 'synth'
RUN mv $SCRIPTS/passwordless-sudo /etc/sudoers.d/

# set up 'synth' account
ENV SYNTH_HOME=/home/synth
ENV PROJECT_HOME=$SYNTH_HOME/Projects
ENV SYNTH_SCRIPTS=$SYNTH_HOME/scripts
ENV SYNTH_LOGS=$SYNTH_HOME/logs
ENV SYNTH_PLOTS=$SYNTH_HOME/plots
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/notebooks
RUN mkdir --parents $PROJECT_HOME $SYNTH_SCRIPTS $SYNTH_LOGS $SYNTH_PLOTS $SYNTH_NOTEBOOKS
RUN cp -rp /usr/local/share/cusignal-notebooks $SYNTH_NOTEBOOKS/
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

COPY --chown=synth:synth synth_home $SYNTH_HOME
RUN apt list --installed > $SYNTH_LOGS/installed-apt-packages.log

# switch back to 'root' for wrap-up
USER root
WORKDIR $SOURCE_DIR

# set entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
