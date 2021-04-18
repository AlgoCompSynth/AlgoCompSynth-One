FROM "nvcr.io/nvidia/l4t-base:r32.5.0"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN ls -lR /usr/local > $LOGS/before.log
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base and libraries
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh
COPY install-libraries.sh pgdg.list $SCRIPTS/
RUN $SCRIPTS/install-libraries.sh

COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/bin /usr/local/bin
COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/etc /usr/local/etc
COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/games /usr/local/games
COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/include /usr/local/include
COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/lib /usr/local/lib
COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/sbin /usr/local/sbin
COPY --from=algocompsynth/internal-ubuntu-builder:latest /usr/local/share /usr/local/share

COPY R.conf /etc/ld.so.conf.d/
COPY configure-r.sh $SCRIPTS/
RUN $SCRIPTS/configure-r.sh > $LOGS/configure-r.log 2>&1

COPY csound.sh $SCRIPTS/
RUN $SCRIPTS/csound.sh
RUN detonate

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
COPY --chown=synth:synth \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/
COPY --chown=synth:synth Rprofile $SYNTH_HOME/.Rprofile
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

# Miniforge
COPY --chown=synth:synth miniforge.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/miniforge.sh

# JupyterLab / cusignal / R base
COPY --chown=synth:synth cusignal.sh $SYNTH_HOME/Scripts/
ENV CUSIGNAL_VERSION="0.18.0"
RUN $SYNTH_HOME/Scripts/cusignal.sh

CMD [ "/bin/bash" ]
