FROM "docker.io/algocompsynth/ml-base:latest"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ENV CHUCK_VERSION="1.4.0.1"
COPY chuck.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/chuck.sh

ENV CUSIGNAL_VERSION="0.18.0"
COPY cusignal.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/cusignal.sh
