FROM "docker.io/algocompsynth/base"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER root
WORKDIR $SOURCE_DIR

COPY supercollider.sh $SCRIPTS/
ENV SUPERCOLLIDER_VERSION="3.11.2"
ENV SC3_PLUGINS_VERSION="3.11.1"
RUN $SCRIPTS/supercollider.sh

COPY tidal.sh $SCRIPTS/
RUN $SCRIPTS/tidal.sh

USER synth
WORKDIR $SYNTH_HOME
