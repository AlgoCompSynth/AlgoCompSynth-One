FROM "nvcr.io/nvidia/l4t-base:r32.7.1"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
ENV SYNTH_ENV_FILE=$SYNTH_SCRIPTS/cusignal_jetson_base.yml

# set up 'synth' account
COPY docker-scripts/synth-user.sh /
RUN /synth-user.sh > /synth-user.log 2>&1

# enable passwordless sudo for 'synth'
COPY docker-scripts/passwordless-sudo /etc/sudoers.d/

# make virtual desktop
RUN mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_PROJECTS \
  && chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing Linux dependencies
COPY --chown=synth:synth Home/Scripts/linux-dependencies.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

# Installing Mambaforge
COPY --chown=synth:synth Home/Scripts/mambaforge.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

# Creating fresh mamba environment 'r-reticulate'
## NVIDIA PyTorch wheels require this
ENV PYTHON_VERSION="3.6"
## Newer versions yield a PyTorch crash on import!
ENV TYPING_EXTENSIONS_VERSION="4.1.1"
COPY --chown=synth:synth Home/Scripts/r-reticulate* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1

# Installing PyTorch
## we are frozen at PyTorch 1.10.0 / torchaudio 0.10.0 because
## torchaudio 0.10.0 is the last release that supports Python 3.6.
ENV PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
ENV PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
ENV TORCHAUDIO_VERSION="0.10.0"
COPY --chown=synth:synth Home/Scripts/*pytorch* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
RUN $SYNTH_SCRIPTS/test-pytorch.sh

# Installing torchaudio
COPY --chown=synth:synth Home/Scripts/*torchaudio* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
RUN $SYNTH_SCRIPTS/test-torchaudio.sh

# Installing cusignal
## newest release
ENV CUSIGNAL_VERSION="22.04.00"
## Run testing in Docker builds
ENV CUSIGNAL_TEST="1"
COPY --chown=synth:synth Home/Scripts/cusignal.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

# Installing R developer tools
## Newer versions break torchaudio for some reason
ENV R_BASE_VERSION="4.0.2"
COPY --chown=synth:synth Home/Scripts/*devtools* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

# Installing R sound packages
COPY --chown=synth:synth Home/Scripts/*sound* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/R-sound.sh > $SYNTH_LOGS/R-sound.log 2>&1

# Installing JupyterLab
COPY --chown=synth:synth Home/Scripts/jupyterlab.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/jupyterlab.sh > $SYNTH_LOGS/jupyterlab.log 2>&1

# Installing home directory scripts
COPY --chown=synth:synth \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  Home/start-jupyter-lab.sh \
  $SYNTH_HOME/

# Finished!
