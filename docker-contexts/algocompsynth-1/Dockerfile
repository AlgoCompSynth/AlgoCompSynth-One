FROM "nvcr.io/nvidia/l4t-base:r32.5.0" As packages
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh

COPY cmake.sh $SCRIPTS/
ENV CMAKE_VERSION="3.20.0"
RUN $SCRIPTS/cmake.sh

ENV XPRA_VERSION="4.1.2"
COPY package-xpra.sh $SCRIPTS/
RUN $SCRIPTS/package-xpra.sh

ENV XPRA_HTML5_VERSION="4.1.2"
COPY package-xpra-html5.sh $SCRIPTS/
RUN $SCRIPTS/package-xpra-html5.sh

FROM "nvcr.io/nvidia/l4t-base:r32.5.0"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS
RUN echo "set bg=dark" >> /root/.vimrc

WORKDIR $SOURCE_DIR

# install command-line base
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh

COPY cmake.sh $SCRIPTS/
ENV CMAKE_VERSION="3.20.0"
RUN $SCRIPTS/cmake.sh

COPY --from=packages \
  $SOURCE_DIR/xpra_4.1.2-1_arm64.deb \
  $SOURCE_DIR/xpra-html5/dist/xpra-html5-4.1.2-1.deb \
  $SOURCE_DIR/
RUN apt-get install -y --no-install-recommends \
  $SOURCE_DIR/xpra-html5-4.1.2-1.deb \
  $SOURCE_DIR/xpra_4.1.2-1_arm64.deb \
  > $LOGS/xpra.log 2>&1

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

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
  start-jupyter-lab.sh \
  $SYNTH_HOME/
RUN chown -R synth:synth $SYNTH_HOME

# get cuSignal done as soon as possible because 
# it takes a long time
USER synth
WORKDIR $SYNTH_HOME

# Miniforge
COPY --chown=synth:synth miniforge.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/miniforge.sh

# JupyterLab / cusignal
COPY --chown=synth:synth cusignal.sh $SYNTH_HOME/Scripts/
ENV CUSIGNAL_VERSION="0.18.0"
RUN $SYNTH_HOME/Scripts/cusignal.sh

USER root
WORKDIR $SOURCE_DIR

COPY fluidsynth.sh $SCRIPTS/
ENV FLUIDSYNTH_VERSION="2.2.0"
RUN $SCRIPTS/fluidsynth.sh

COPY llvm.sh $SCRIPTS/
ENV LLVM_VERSION="11.0.1"
RUN $SCRIPTS/llvm.sh

COPY faust.sh $SCRIPTS/
ENV FAUST_VERSION="2.30.5"
RUN $SCRIPTS/faust.sh

COPY pure-data.sh $SCRIPTS/
ENV PURE_DATA_VERSION="0.51-4"
RUN $SCRIPTS/pure-data.sh

COPY csound.sh $SCRIPTS/
ENV CSOUND_VERSION="6.15.0"
RUN $SCRIPTS/csound.sh

COPY supercollider.sh $SCRIPTS/
ENV SUPERCOLLIDER_VERSION="3.11.2"
ENV SC3_PLUGINS_VERSION="3.11.1"
RUN $SCRIPTS/supercollider.sh

USER synth
WORKDIR $SYNTH_HOME

CMD [ "/bin/bash" ]
