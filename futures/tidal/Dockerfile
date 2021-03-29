FROM "docker.io/algocompsynth/base:latest"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ENV SUPERCOLLIDER_VERSION="Version-3.11.1"
ENV SC3_PLUGINS_VERSION="Version-3.11.1"
COPY supercollider.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/supercollider.sh

COPY tidal.sh $SYNTH_HOME/Scripts
RUN $SYNTH_HOME/Scripts/tidal.sh
