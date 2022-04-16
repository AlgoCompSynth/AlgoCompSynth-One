FROM "nvcr.io/nvidia/l4t-base:r32.7.1"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# NVIDIA PyTorch wheels require this
ENV PYTHON_VERSION="3.6"

# Newer versions break torchaudio for some reason
ENV R_BASE_VERSION="4.0.2"

# newest version
ENV CUSIGNAL_VERSION="22.04.00"

# Testing takes too long
ENV CUSIGNAL_TEST="0"

# newest PyTorch version from NVIDIA
ENV PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
ENV PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"

# matches PyTorch version
ENV TORCHAUDIO_VERSION="0.10.0"

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
ENV SYNTH_ENV_FILE=$SYNTH_SCRIPTS/cusignal_jetson_base.yml

# set up 'synth' account
COPY synth-user.sh /
RUN /synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

# make virtual desktop
COPY --chown=synth:synth \
  build-r-reticulate.sh \
  Home \
  $SYNTH_HOME/

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

RUN $SYNTH_HOME/build-r-reticulate.sh

RUN echo "Installing Linux dependencies"
RUN $SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

RUN echo "Installing Mambaforge if needed"
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

RUN echo "Installing cusignal in fresh mamba environment 'r-reticulate'"
RUN sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/cusignal_jetson_base_template \
  > $SYNTH_ENV_FILE
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

RUN echo "Installing PyTorch"
RUN /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
RUN $SYNTH_SCRIPTS/test-pytorch.sh

RUN echo "Installing torchaudio"
RUN /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh #> $SYNTH_LOGS/torchaudio.log 2>&1
RUN $SYNTH_SCRIPTS/test-torchaudio.sh

RUN echo "Installing JupyterLab"
RUN /usr/bin/time $SYNTH_SCRIPTS/jupyterlab.sh > $SYNTH_LOGS/jupyterlab.log 2>&1

RUN echo "Installing R developer tools"
RUN /usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

RUN echo "Installing R audio packages"
RUN /usr/bin/time $SYNTH_SCRIPTS/R-audio.sh > $SYNTH_LOGS/R-audio.log 2>&1

RUN echo "Finished!"
