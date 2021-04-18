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

# set up 'synth' account
COPY synth-user.sh $SCRIPTS/
RUN $SCRIPTS/synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

ENV SYNTH_HOME=/home/synth
RUN mkdir --parents \
  $SYNTH_HOME/Scripts \
  $SYNTH_HOME/Downloads/Installers \
  $SYNTH_HOME/Logfiles
RUN echo "set bg=dark" >> $SYNTH_HOME/.vimrc
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

ENV CMAKE_VERSION="3.20.0"
ENV XPRA_VERSION="4.1.1"
COPY package-xpra.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/package-xpra.sh

ENV XPRA_HTML5_VERSION="4.1.2"
COPY package-xpra-html5.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/package-xpra-html5.sh
RUN cp $SYNTH_HOME/Downloads/Installers/xpra-html5/dist/*.deb $SYNTH_HOME/Downloads/Installers/
