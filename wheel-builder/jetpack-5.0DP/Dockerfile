FROM "nvcr.io/nvidia/l4t-base:r34.1"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# virtual desktop
ENV SYNTH_HOME=/home/synth
ENV SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
ENV SYNTH_LOGS=$SYNTH_HOME/Logs
ENV SYNTH_PROJECTS=$SYNTH_HOME/Projects
ENV SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks
ENV SYNTH_WHEELS=$SYNTH_HOME/Wheels
ENV WORKON_HOME=$SYNTH_HOME/.virtualenvs

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
  $SYNTH_WHEELS \
  $WORKON_HOME \
  && chown -R synth:synth $SYNTH_HOME

USER synth
WORKDIR $SYNTH_HOME
CMD [ "/bin/bash" ]

# Installing home directory scripts
COPY --chown=synth:synth \
  Home/bash_aliases \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  Home/start-jupyter-lab.sh \
  $SYNTH_HOME/
RUN cat $SYNTH_HOME/bash_aliases >> $SYNTH_HOME/.bash_aliases

# Installing Linux dependencies
COPY --chown=synth:synth Home/Scripts/linux-dependencies.sh $SYNTH_SCRIPTS/
RUN $SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

# Creating fresh Python 3 venv 'r-reticulate'
COPY --chown=synth:synth Home/Scripts/r-reticulate.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1

# Installing cupy - this takes a *long* time!
COPY --chown=synth:synth Home/Scripts/cupy.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/cupy.sh > $SYNTH_LOGS/cupy.log 2>&1

# Installing cusignal
## newest release
ENV CUSIGNAL_VERSION="22.04.00"
## Run testing in Docker builds
ENV CUSIGNAL_TEST="1"
COPY --chown=synth:synth Home/Scripts/cusignal.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

# Installing PyTorch
ENV PYTORCH_WHEEL_URL="https://developer.download.nvidia.com/compute/redist/jp/v50/pytorch/torch-1.12.0a0+2c916ef.nv22.3-cp38-cp38-linux_aarch64.whl"
ENV PYTORCH_WHEEL_FILE="torch-1.12.0a0+2c916ef.nv22.3-cp38-cp38-linux_aarch64.whl"
COPY --chown=synth:synth Home/Scripts/*pytorch* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
RUN $SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

# Installing torchaudio
ENV TORCHAUDIO_VERSION="0.11.0"
COPY --chown=synth:synth Home/Scripts/*torchaudio* $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
RUN $SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

# Installing TensorFlow to build dependency wheels
ENV TENSORFLOW_WHEEL_URL="https://developer.download.nvidia.com/compute/redist/jp/v50/tensorflow/tensorflow-2.8.0+nv22.3-cp38-cp38-linux_aarch64.whl"
ENV TENSORFLOW_WHEEL_FILE="tensorflow-2.8.0+nv22.3-cp38-cp38-linux_aarch64.whl"
COPY --chown=synth:synth Home/Scripts/tensorflow.sh $SYNTH_SCRIPTS/
RUN /usr/bin/time $SYNTH_SCRIPTS/tensorflow.sh > $SYNTH_LOGS/tensorflow.log 2>&1

# Finished!
