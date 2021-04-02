FROM "docker.io/algocompsynth/base"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER root
WORKDIR SOURCE_DIR

# Pandoc
ENV PANDOC_VERSION="2.12"
COPY upstream-pandoc.sh $SCRIPTS/
RUN $SCRIPTS/upstream-pandoc.sh

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=5
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY R.conf /etc/ld.so.conf.d/R.conf
COPY r-from-source.sh $SCRIPTS/
RUN $SCRIPTS/r-from-source.sh
COPY audio.sh audio.R $SCRIPTS/
RUN $SCRIPTS/audio.sh

COPY --chown=synth:synth Scripts $SYNTH_HOME/Scripts
COPY --chown=synth:synth Rprofile $SYNTH_HOME/.Rprofile
RUN chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME

# Miniforge
RUN $SYNTH_HOME/Scripts/miniforge.sh

# TinyTex
RUN $SYNTH_HOME/Scripts/install-tinytex.sh
