FROM "nvcr.io/nvidia/l4t-base:r32.7.1"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# NVIDIA PyTorch wheels require this
ENV PYTHON_VERSION="3.6"

# Newer versions break torchaudio for some reason
ENV R_BASE_VERSION="4.0.2"

# newest version
ENV CUSIGNAL_VERSION="22.04.00"

# Run testing in Docker builds
ENV CUSIGNAL_TEST="1"

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

ENV DOCKER_IMAGE=1

# set up 'synth' account
COPY synth-user.sh /
RUN /synth-user.sh

# enable passwordless sudo for 'synth'
COPY passwordless-sudo /etc/sudoers.d/

# make virtual desktop
COPY --chown=synth:synth Home $SYNTH_HOME/

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing Linux dependencies
RUN $SYNTH_SCRIPTS/linux-dependencies.sh 2>&1 | gzip -c > $SYNTH_LOGS/linux-dependencies.log.gz

# Installing Mambaforge if needed
RUN $SYNTH_SCRIPTS/mambaforge.sh 2>&1 | gzip -c > $SYNTH_LOGS/mambaforge.log.gz

# Installing cusignal in fresh mamba environment 'r-reticulate'
RUN sed s/PYTHON_VERSION/$PYTHON_VERSION/ $SYNTH_SCRIPTS/cusignal_jetson_base_template \
  > $SYNTH_ENV_FILE
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh 2>&1 | gzip -c > $SYNTH_LOGS/cusignal.log.gz

# Installing PyTorch
RUN /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh 2>&1 | gzip -c > $SYNTH_LOGS/pytorch.log.gz
RUN $SYNTH_SCRIPTS/test-pytorch.sh

# Installing torchaudio
RUN /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh 2>&1 | gzip -c > $SYNTH_LOGS/torchaudio.log.gz
RUN $SYNTH_SCRIPTS/test-torchaudio.sh

# Installing JupyterLab
RUN /usr/bin/time $SYNTH_SCRIPTS/jupyterlab.sh 2>&1 | gzip -c > $SYNTH_LOGS/jupyterlab.log.gz

# Installing R developer tools
RUN /usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh 2>&1 | gzip -c > $SYNTH_LOGS/R-devtools.log.gz

# Installing R audio packages
RUN /usr/bin/time $SYNTH_SCRIPTS/R-audio.sh 2>&1 | gzip -c > $SYNTH_LOGS/R-audio.log.gz

# Finished!
