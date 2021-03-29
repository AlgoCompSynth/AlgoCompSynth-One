FROM "docker.io/algocompsynth/ml-base:latest"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ENV LIBMUSICXML_VERSION="3.18"
COPY libmusicxml.sh $SYNTH_HOME/Scripts/
RUN $SYNTH_HOME/Scripts/libmusicxml.sh

ENV FAUST_VERSION="2.30.5"
COPY faust.sh $SYNTH_HOME/Scripts
RUN $SYNTH_HOME/Scripts/faust.sh

ENV CSOUND_VERSION="6.15.0"
COPY csound.sh $SYNTH_HOME/Scripts
RUN $SYNTH_HOME/Scripts/csound.sh
