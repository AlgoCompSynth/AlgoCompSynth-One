FROM "nvcr.io/nvidia/l4t-base:r32.5.0"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

RUN echo "set bg=dark" >> /root/.vimrc

# Utility to get RAM size
COPY ram_kilobytes.sh /usr/local/bin/

# Command line basics and audio libraries
COPY base.sh $SCRIPTS
RUN $SCRIPTS/base.sh

# Xpra
COPY --from="algocompsynth/xpra:latest" /home/synth/Projects/xpra_4.1.1-1_arm64.deb $SOURCE_DIR/
RUN apt install -qqy --no-install-recommends \
  $SOURCE_DIR/xpra_4.1.1-1_arm64.deb > $LOGS/xpra.log 2>&1 \
  && rm -f $SOURCE_DIR/xpra_4.1.1-1_arm64.deb

# VScode
RUN wget --quiet \
  https://az764295.vo.msecnd.net/stable/c185983a683d14c396952dd432459097bc7f757f/code_1.55.0-1617120113_arm64.deb
RUN apt install -qqy --no-install-recommends \
  $SOURCE_DIR/code_1.55.0-1617120113_arm64.deb > $LOGS/VScode.log 2>&1 \
  && rm -f $SOURCE_DIR/code_1.55.0-1617120113_arm64.deb

COPY llvm.sh $SCRIPTS/
ENV LLVM_VERSION="11.0.1"
RUN $SCRIPTS/llvm.sh

COPY cmake.sh $SCRIPTS/
ENV CMAKE_VERSION="3.20.0"
RUN $SCRIPTS/cmake.sh

COPY fluidsynth.sh $SCRIPTS/
ENV FLUIDSYNTH_VERSION="2.1.8"
RUN $SCRIPTS/fluidsynth.sh

# Define the startup command
CMD [ "/bin/bash" ]
