FROM "docker.io/algocompsynth/base"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

COPY llvm.sh $SCRIPTS
ENV LLVM_VERSION="11.0.1"
RUN $SCRIPTS/llvm.sh

COPY cmake.sh $SCRIPTS
ENV CMAKE_VERSION="3.20.0"
RUN $SCRIPTS/cmake.sh

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
COPY --chown=synth:synth Logfiles $SYNTH_HOME/Logfiles
RUN echo "set bg=dark" >> $SYNTH_HOME/.vimrc
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

COPY fluidsynth.sh $SYNTH_HOME/Scripts
ENV FLUIDSYNTH_VERSION="2.1.8"
RUN $SYNTH_HOME/Scripts/fluidsynth.sh

COPY supercollider.sh $SYNTH_HOME/Scripts
ENV SUPERCOLLIDER_VERSION="3.11.2"
ENV SUPERCOLLIDER_REPO="https://github.com/supercollider/supercollider/releases/download/Version-$SUPERCOLLIDER_VERSION"
ENV SUPERCOLLIDER_TARBALL="$SUPERCOLLIDER_REPO/SuperCollider-$SUPERCOLLIDER_VERSION-Source.tar.bz2"
ENV SC3_PLUGINS_VERSION="3.11.1"
ENV SC3_PLUGINS_REPO="https://github.com/supercollider/sc3-plugins/releases/download/Version-$SC3_PLUGINS_VERSION"
ENV SC3_PLUGINS_TARBALL="$SC3_PLUGINS_REPO/sc3-plugins-$SC3_PLUGINS_VERSION-Source.tar.bz2"
RUN $SYNTH_HOME/Scripts/supercollider.sh

COPY faust.sh $SYNTH_HOME/Scripts
ENV FAUST_VERSION="2.30.5"
RUN $SYNTH_HOME/Scripts/faust.sh

COPY pure-data.sh $SYNTH_HOME/Scripts
ENV PURE_DATA_VERSION="0.51-4"
RUN $SYNTH_HOME/Scripts/pure-data.sh

COPY csound.sh $SYNTH_HOME/Scripts
ENV CSOUND_VERSION="6.15.0"
RUN $SYNTH_HOME/Scripts/csound.sh
