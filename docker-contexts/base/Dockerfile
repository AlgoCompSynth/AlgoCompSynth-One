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
COPY \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  $SYNTH_HOME/
RUN chown -R synth:synth $SYNTH_HOME

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

# VScode
RUN wget --quiet \
  https://az764295.vo.msecnd.net/stable/c185983a683d14c396952dd432459097bc7f757f/code_1.55.0-1617120113_arm64.deb
RUN apt install -qqy --no-install-recommends \
  $SOURCE_DIR/code_1.55.0-1617120113_arm64.deb > $LOGS/VScode.log 2>&1 \
  && rm -f $SOURCE_DIR/code_1.55.0-1617120113_arm64.deb

COPY cmake.sh $SCRIPTS/
ENV CMAKE_VERSION="3.20.0"
RUN $SCRIPTS/cmake.sh

COPY fluidsynth.sh $SCRIPTS/
ENV FLUIDSYNTH_VERSION="2.1.8"
RUN $SCRIPTS/fluidsynth.sh

USER synth
WORKDIR $SYNTH_HOME

# Define the startup command
CMD [ "/bin/bash" ]
