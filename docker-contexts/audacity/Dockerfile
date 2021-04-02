FROM "docker.io/algocompsynth/base"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER root
WORKDIR $SOURCE_DIR

COPY wxWidgets.sh $SCRIPTS/
RUN $SCRIPTS/wxWidgets.sh

COPY audacity.sh $SCRIPTS/
ENV AUDACITY_VERSION="3.0.0"
RUN $SCRIPTS/audacity.sh

USER synth
WORKDIR $SYNTH_HOME
